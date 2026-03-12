from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
import os
import time

GOOSEHASH_IV = b"Honk! Honk! Honk"
GOOSEHASH_KEY = b"Geese are great!"
GOOSEHASH_RATE = 11  
GOOSEHASH_CAPACITY = 16 - GOOSEHASH_RATE  
GOOSEHASH_OUTPUT_LENGTH = 32  
GOOSEHASH_CIPHER = Cipher(algorithms.AES(GOOSEHASH_KEY), modes.ECB())


def read_binary_file(filename):
    binary_data = []
    with open(filename, "rb") as f:
        while (next_byte := f.read(1)):
            binary_data += next_byte
    return bytes(binary_data)


def Permute(state):
    return GOOSEHASH_CIPHER.encryptor().update(state)


def InvPermute(state):
    """AES decryption inverse of Permute"""
    return GOOSEHASH_CIPHER.decryptor().update(state)


def Absorb(state, block):
    assert len(state) == GOOSEHASH_RATE + GOOSEHASH_CAPACITY
    assert len(block) == GOOSEHASH_RATE
    xored_state = bytes(GOOSEHASH_CAPACITY) + block
    new_state = bytes([state[i] ^ xored_state[i] for i in range(len(state))])
    new_state = Permute(new_state)
    return new_state


def Squeeze(state):
    output = state[GOOSEHASH_CAPACITY:]
    return Permute(state), output


def GooseHash(X):
    assert len(X) % GOOSEHASH_RATE == 0
    state = bytes(GOOSEHASH_IV)
    for j in range(0, len(X), GOOSEHASH_RATE):
        state = Absorb(state, X[j : j + GOOSEHASH_RATE])
    c = []
    while len(c) < GOOSEHASH_OUTPUT_LENGTH:
        state, next_output = Squeeze(state)
        c += list(next_output)
    return bytes(c[:GOOSEHASH_OUTPUT_LENGTH])


def second_preimage_attack(X):
    """
    Second preimage attack on GooseHash exploiting the small 40-bit capacity.
    """
    assert len(X) % GOOSEHASH_RATE == 0
    
    num_blocks = len(X) // GOOSEHASH_RATE
    target_hash = GooseHash(X)
    
    # Process X, record intermediate states
    iv = bytes(GOOSEHASH_IV)
    state = iv
    states_of_X = []  
    for j in range(num_blocks):
        block = X[j * GOOSEHASH_RATE : (j + 1) * GOOSEHASH_RATE]
        state = Absorb(state, block)
        states_of_X.append(state)
    
    # Try direct matching first 
    target_caps = {}  # cap -> (j, inv_j)
    for j in range(num_blocks):
        inv_j = InvPermute(states_of_X[j])
        cap = inv_j[:GOOSEHASH_CAPACITY]
        if cap not in target_caps:
            target_caps[cap] = (j, inv_j)
    
    # Generate forward states and check direct match
    N = 2**21
    forward = {}  
    
    print(f"Building forward set ({N} entries)...")
    for i in range(N):
        b_fwd = os.urandom(GOOSEHASH_RATE)
        state_fwd = Absorb(iv, b_fwd)
        cap = state_fwd[:GOOSEHASH_CAPACITY]
        
        # Check direct match
        if cap in target_caps:
            j, inv_j = target_caps[cap]
            link_block = bytes([state_fwd[GOOSEHASH_CAPACITY + k] ^ inv_j[GOOSEHASH_CAPACITY + k]
                               for k in range(GOOSEHASH_RATE)])
            suffix = X[(j + 1) * GOOSEHASH_RATE:]
            X_prime = b_fwd + link_block + suffix
            if X_prime != X and GooseHash(X_prime) == target_hash:
                print(f"Direct match at j={j}!")
                return X_prime
        
        if cap not in forward:
            forward[cap] = (b_fwd, state_fwd)
    
    print(f"Forward set size: {len(forward)}")
    
    # 2-step backward expansion for each s_j, generate predecessors
    # and check if 2-step-back capacity matches forward set
    print("Searching with 2-step backward expansion...")
    PER_STATE = max(1, N // num_blocks)
    
    for j in range(1, num_blocks):
        s_j = states_of_X[j]
        inv_j = InvPermute(s_j)
        
        for _ in range(PER_STATE):
            # Random block b1 maps predecessor 
            b1 = os.urandom(GOOSEHASH_RATE)
            p_cap = inv_j[:GOOSEHASH_CAPACITY]
            p_rate = bytes([inv_j[GOOSEHASH_CAPACITY + k] ^ b1[k] for k in range(GOOSEHASH_RATE)])
            p = p_cap + p_rate
            
            # To connect forward state to p, need capacity match on InvPermute(p)
            inv_p = InvPermute(p)
            target_cap = inv_p[:GOOSEHASH_CAPACITY]
            
            if target_cap in forward:
                b_fwd, state_fwd = forward[target_cap]
                
                # link_block connects state_fwd to p
                link_block = bytes([state_fwd[GOOSEHASH_CAPACITY + k] ^ inv_p[GOOSEHASH_CAPACITY + k]
                                   for k in range(GOOSEHASH_RATE)])
                
                suffix = X[(j + 1) * GOOSEHASH_RATE:]
                X_prime = b_fwd + link_block + b1 + suffix
                
                if X_prime != X and GooseHash(X_prime) == target_hash:
                    print(f"2-step match at j={j}!")
                    return X_prime
    
    print("No collision found. Retry.")
    return None


if __name__ == "__main__":
    X = read_binary_file("goosebin.dat")
    print(f"X length: {len(X)} bytes, blocks: {len(X) // GOOSEHASH_RATE}")
    print(f"GooseHash(X) = {GooseHash(X).hex()}")
    
    start = time.time()
    X_prime = second_preimage_attack(X)
    elapsed = time.time() - start
    
    if X_prime is not None:
        print(f"\nTime: {elapsed:.2f}s")
        print(f"GooseHash(X)  = {GooseHash(X).hex()}")
        print(f"GooseHash(X') = {GooseHash(X_prime).hex()}")
        print(f"len(X') = {len(X_prime)}, X != X': {X != X_prime}")
        
        with open("second_preimage.dat", "wb") as f:
            f.write(X_prime)
        print("Saved second preimage to second_preimage.dat")
