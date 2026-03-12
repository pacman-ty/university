#import "@preview/theorion:0.4.0": *
#import cosmos.fancy: *
// #import cosmos.rainbow: *
// #import cosmos.clouds: *
#show: show-theorion

#set page(height: auto)
#set page("a4") // Sets the page size to A4
#set heading(numbering: "1.1")
#set text(lang: "en")

#let title-page(title:[], email:[], name:[], fill: yellow, body) = {
  set page(fill: rgb("#FFD700"), margin: (top: 1.5in, rest: 2in))
  set heading(numbering: "1.1.1")
  line(start: (0%, 0%), end: (8.5in, 0%), stroke: (thickness: 2pt))
  align(horizon + left)[
    #text(size: 24pt, title)\
    #v(1em)
    Winter 2026 - Samuel Jaques
    #v(2em)
    #name, #linebreak() #email
  ]
  
  align(bottom + left)[]
  pagebreak()
  set page(fill: none, margin: auto)
  align(outline(indent: auto))
  pagebreak()
  body
}

#show: body => title-page(
  title: [CO 487 Course Notes: \ Applied Cryptography],
  name: [Talha Yildirim],
  email: [ tyildir [ at ] uwaterloo [ dot ] ca ],
  body
)

// order important so it doesnt effect content and title page 

#set page(header: [
  _CO 487 Course Notes_
  #h(1fr)
  Talha Yildirim $<$$3$ 
])

#set page(numbering: "1 of 1")

// BEGIN NOTES BELOW

= Intro and History

#linebreak()

#definition(title: "Cryptography")[
  Cryptography is about securing communications in the presence of malicious adversaries
]

#remark[
  *States of information*

  - Data at rest 
  - Data at transit 
  - Data while processing
]

#corollary(title: "Fundamental Goals of Cryptography")[
  - *Confidentiality -* Keeping data secret from all but those authorized to see it
  - *Integrity -* Ensuring data has not been altered by unauthorized means 
  - *Authentication -* Corroborating the source of data or identity of an entity 
  - *Non-repudiation -* Preventing an entity from denying previous commitments or actions 
  - *Deniability -* Allowing an entity to deny previous commitments or actions 
  - *Consensus -* Ensuring a number of entities agree on the state of some data 
  - *Availability -* Ensuring a computer system works even if parts of it fail or are tampered with
]

#remark[
  #figure(
    image("images/cbb.png", width: 80%),
    caption: [Cryptography building blocks],
  )
  
  #linebreak() 

  *Symmetric cryptography:* Uses a single shared secret to protect data. Both parties use the same secret, so it is simple and efficient, but requires the secret to be shared securely.

  *Asymmetric cryptography:* Uses two related keys, one public and one private. This allows parties to communicate or verify identity without sharing a secret first, at the cost of being more complex and slower.
]

#definition(title: "Caesar Cipher")[
  Caesar cipher is a simple substitution cipher that encrypts text by shifting each letter a fixed number of positions forward in the alphabet, wrapping around at the end
  
  #figure(
    image("images/caeser_cipher.png"),
  )

  This scheme is *NOT* secure
]

#remark[
  Note the difference between "encrypt" and "encode", and "decrypt" and "decode"

  - *encode and decode* map letters to numbers without trying to add security – just mapping
to a more convenient space

  - *encrypt and decrypt* try to add security
]

#definition(title: "Shift Cipher")[
  Idea: Modify Caesar cipher by introducing a secret key 

  #figure(
    image("images/shift_cipher.png")
  )

  This scheme is *NOT* secure
]

#pagebreak()

How might we break the shift cipher?

#linebreak()

*Assumptions*

#definition(title: "Kerckhoff's Principal")[
  We know the encryption / decryption algorithm being used but not any secret keys
]

and, 

We are given a cipher text to break

#linebreak()

*Two approaches* 

1. Try all 26 possible secret key values $k = 0, dots , 25$ (brute force / exhaustive key search)

2. Frequency Analysis

#linebreak()

#definition(title: "Frequency Analysis")[
  Compare the distribution of letters in the cipher text with the distribution of letters in the underlying plain text space 

  #figure(
    image("images/freq_anal.png"),
    caption: [$k = 2$]
  )
]

#definition(title: "Vigenere Cipher")[
  Use different shift ciphers for different parts of the message to reduce effect of frequency analysis

  #figure(
    image("images/vin_cipher1.png")
  )

  #figure(
    image("images/vin_cipher2.png")
  )

  This scheme is *NOT* secure
]

= Symmetric Encryption 

== Block Ciphers 

#linebreak()

#definition(title: "Stream Cipher")[
  A stream cipher is a symmetric key encryption scheme in which each successive character of plaintext determines a single character of ciphertext

  #figure(
    image("images/stream_cipher.png")
  )
]

#definition(title: "Block Cipher")[
  A block cipher is a symmetric key encryption scheme in which a fixed length block of plaintext determines an equal sized block of ciphertext 

  e.g. AES, DES 

  #figure(
    image("images/block_cipher.png", width: 50%)
  )
]

#corollary(title: "Desirable Properties of Block Ciphers")[
  - *Security*
    - *Diffusion:* Each ciphertext bit should depend on all plaintext and all key bits 

    - *Confusion:* The relationship between key bits, plaintext bits, and ciphertext bits should be complicated 

    - *Cascade or Avalanche Effect:* Changing one bit of plaintext or key should change each bit of ciphertext with 50% probability

    - *Key Length:* Should be small, but large enough to preclude exhaustive key search 

  - *Efficiency*
    - Simplicity (easier to implement and analyze) 
    - High encryption and decryption rate 
    - Suitability for hardware or software
]

#definition(title: "Substitution Permutation Networks")[
  A substitution permutation network (SPN) is a multiple round iterated block cipher where each round consist of a substitution operation followed by a permutation operation. During each round, a round key is `XOR`ed into the state. The round keys $k_i$ are derived from the main key $k$ using a key schedule function.

  #figure(
    image("images/spn.png", width: 50%)
  )

]

#warning-box[
  Despite being called a Substitution Permutation Network, the permutation can be any invertible linear function. 
]

#remark[
  To a mathematician, any bijective (one-to-one) function on a finite set can be considered a "permutation". To avoid confusion lets clarify permutation and substitution in a substitution permutation network.

  1. *Bijection or Substitution*

  The S-box will (often) be a one-to-one function on some small space 

  e.g. 4 or 8 bit strings

  11110001 $arrow.r$ 10100001

  11110010 $arrow.r$ 01000101

  In this course this will be referred to as a bijection or substitution

  2. *Permutation*

  The permutation will be a one-to-one function of positions of bits. 

  e.g. A block of 128 bits 

  $p : {0, 1, 2, dots , 127 } arrow {0, 1, 2, dots , 127}$

  This tells us to move the bit at position $i$ to position $p(i)$
]

#remark[
  Two perspectives on a permutation 

  1. As a function from bit position to bit position (i.e a one-to-one function on ${0, 2, dots}, 127$) 

  2. As a function from bit strings to bit strings (i.e take each bit in the bit string and rearrange it according to how the positions are permuted)

]

#figure(
  image("images/permutation_matrix.png")
)

#definition(title: "The Advanced Encryption Standard (AES)")[
  *Requirements*
    - *Key Sizes:* 128, 192 and 256 bits
    - *Block Sizes:* 128 bits
    - Efficient on both hardware and software platforms 
    - Availability on a worldwide, non-exclusive, royalty-free basis

  - AES is a SPN where the "permutation" operation consist of two linear transformations (one of which is a permutation)
  - All operations are byte oriented 

  Number of rounds depends on the key length 

  #figure(
    image("images/aes_key_length.png", width: 40%)
  )

  - The substitution operation (S-box) is the only non-linear component 
  - The permutation operations (permutation and linear transformations) spread out the non-linearities in each round 

]

#corollary(title: "AES Round Operations")[
  - Each round updates a variable called `State` which consist of a $4 x 4$ array of bytes (notes: $4 times 4 times 8 = 128$, the block size)

  - `State` is initialized with the $128$-bit plaintext 

  #figure(
    image("images/128_bit_pt.png", width: 50%)
  )

  - After $h$ rounds are completed, one final additional round key is `XOR`ed with `State` to produce the ciphertext
  - The AES round function uses four operations:
    - `AddRoundkey` ,  key mixing
    - `SubBytes` , S-box
    - `ShiftRows` , permutation
    - `MixColumns` , matrix multiplication / linear transformation 
]

#corollary(title: "AES Encryption")[
  From the key $k$, derive $h + 1$ round keys $k_0, k_1, dots , k_h$ via the key schedule 

  Encryption function:

  #figure(
    image("images/aes_encrypt.png", width: 70%)
  )

  Not in the final round `MixColumns` is not applied
]
  

#definition(title: "Data Encryption Standard DES")[
  Block cipher with $64$-bit blocks, $56$-bit key, and $16$ rounds of operation

  #figure(
    image("images/des.png", width: 60%)
  )
]

#definition(title: "Feistel Network Design")[
  - DES uses a Feistel network design 
  - Plaintext is divided into two halves 
  - Key is used to generate subkeys $k_0, k_1, dots , k_h$
  - $f_i$ is a component function whose output value depends on $k_i$ and $m_i$ 

  #figure(
    image("images/feistel.png", width: 40%)
  )
]

#corollary(title: "Feistel Ciphers: A Class of Block Ciphers")[
  - *Components of a Feistel Cipher:*
    - Parameters: $n$ (half the block length), $h$ (number of rounds). $l$ (key size)
    - $M = {0, 1}^(2n)$, $C = {0, 1}^(2n)$, $K = {0, 1}^l$
    - A key scheduling algorithm which determines subkeys $k_0, k_1, dots , k_h$ from a key $k$
    - Each subkey $k_i$ constructs a component function $f_i : {0, 1}^l times {0, 1}^n arrow {0, 1}^n$

  - *Encryption takes $h$ rounds:*
    - Plaintext is $m = (m_0, m_1)$, where $m_i in {0, 1}^n$
    - *Round 1:* $(m_0, m_1) arrow (m_1, m_2)$, where $m_2 = m_0 xor f_1 (k_1, m_1)$
    - *Round 2:* $(m_1, m_2) arrow (m_2, m_3)$, where $m_3 = m_1 xor f_2 (k_2, m_2)$
    - *Round $h$:* $(m_(h - 1), m_h) arrow (m_h, m_(h + 1))$, where $m_(h + 1) = m_(h - 1) xor f_h (k_h, m_h)$
    - Ciphertext is $c = (m_h, m_(h + 1))$
  
  - *Decryption:* Given $c = (m_h, m_(h + 1))$ and $k$, to find $m = (m_0, m_1)$
    - Compute $m_(h - 1) = m_(h + 1) xor f_h (k_h, m_h)$ 
    - Similarly, compute $m_(h - 2), dots , m_1, m_0$
]

#remark[
   - No restrictions on the functions $f_i$ in order for the encryption procedure to be invertible 
   - *Underlying principle:* Take something "simple" and use it several times; hope that the result is "complicated" 
]

#corollary(title: "DES Problem: Small Key Size")[
  Exhaustive seach on key space takes $2^(56)$ steps and can be easily parallelized 
]

#definition(title: "Multiple Encryption")[
  Re-encrypt the ciphertext one or more times using independent keys, and hope that this operation increase the effective key length 

  Multiple encryption does not always increase security. e.g. Substitution cipher 
]

#definition(title: "Double Encryption")[
  - *Double DES:* Key is $k = (k_1, k_2), k_1, k_2 in_R {0 , 1}^(56)$
  - *Encryption:* $c = E_(k 2)(E_(k 1)(m))$
  - *Decryption:* $c = E_(k 1)^(-1)(E_(k 2)^(-1)(m))$
  
  - Key length of Double DES is $l = 112$, so exhaustive key search takes $2^(112)$ steps (infeasible)
]

#corollary(title: "Attack on Double DES")[
  
  Main idea: If $c = E_(k 2)(E_(k 1)(m))$, then $E^(-1)_(k 2) (c) = E_(k 1) (m)$  (meet-in-the-middle)

  1. Given: Known plaintext pairs $(m_i, c_i)$ , $i = 1, 2, 3, dots$
  2. For each $h_2 in {0, 1}^(56)$: 
    - Compute $E_(h 2)^(-1)$, and store $[ E_(h 2)^(-1), h_2$ in a table 
  3. For each $h_1 in {0, 1}^(56)$ do the following
    - Compute $E_(h_1) (m_1)$ 
    - Search for $E_(h_1) (m_1)$ in the table 
    - If $E_(h_1) (m_1) = E^(-1)_(h_2)(c_1)$:
      - Check if $E_(h_1) (m_1) = E^(-1)_(h_2)(c_2)$
      - Check if $E_(h_1) (m_1) = E^(-1)_(h_2)(c_3)$
      - Etc 
      - If all checks pass, then output $(h_1, h_2)$ and stop 

  Complexity of the attack is $approx 2^(57)$
]

#remark[
  - Number of known plaintext / ciphertext pairs required to avoid false keys: 2 suffice, with high probability
  - Number of DES operations $approx 2^(56) + 2^(56) + 2 times 2^(48) approx 2^(57)$
  - Space requirements: $2^56 ( 64 plus 65)$ bits $approx 1,080,863$ Tbytes 


  Double DES effectively has the same key length as DES and isn't much more secure
]

#definition(title: "Three Key Triple Encryption")[
  - *Triple DES:* Key is $k = (k_1, k_2, k_3), k_1, k_2, k_3 in_R {0 , 1}^(56)$
  - *Encryption:* $c = E_(k 3)(E_(k 2)(E_(k 1)(m)))$
  - *Decryption:* $c = E_(k 1)^(-1)(E_(k 2)^(-1)(E^(-1)_(k_3)(m)))$
  
  - Key length of Triple DES is $l = 168$, so exhaustive key search takes $2^(168)$ steps (infeasible)
]

#corollary(title: "Attack on Triple DES")[
  - meet-in-the-middle attack takes $approx 2^112$ steps 
  - So, the effective key length of Triple DES against exhaustive key search is $<= 112$ bits 
  - No proof that Triple DES is more secure than DES
  - Block length is 64 bits, and now forms the weak link:
     - Adversary stores a large table (of size $<= 2^64$) pf $(m, c)$ pairs (dictionary attack)
     - To prevent this attack $arrow$ change secret keys frequently
]

#pagebreak()

== Block Cipher Modes of Operations 

#remark[
  Recall, 

  *Stream Cipher:* A symmetric key encryption scheme in which each a pseudorandom sequence of arbitrary length is generated to encrypt successive character of plaintext of ciphertext 

  *Block Cipher:* A symmetric key encryption scheme in which a fixed length block of plaintext determines an equal sized block of ciphertext 
]

#lemma(title: "Encrypting Bulk Data")[

  What if one needs to encrypt large quantities of data?

  - With a stream cipher, just encrypt each character 
  - With a block cipher, there are some complications if:
    - The input is larger than one block 
    - The input does not fill an integer number of blocks 

  To deal with these problems we use a mode of **operation**, which means a specification for how to encrypt multiple and / or partial data blocks using a block cipher 
]

#definition(title: "Padding")[
  - Some modes namely ECB and CBC, require the plaintext to consist of one or more complete blocks 
  - Padding method 
    - Append a single '1' bit to the data string 
    - Pad the resulting string by as few '0' bits, possible none, as are necessary to complete the final block 
  - The padding bits can be removed unambiguously, if the receiver known that this padding method is used 
]

#definition(title: "Cipher Block Chaining mode (CBC)")[
  Use a single initialization vector for the first block of plaintext, and "chain" the (pseudorandom) ciphertext blocks as the next blocks initialization vectors. The IV is included as part of the ciphertext 
  
  #figure(
    image("images/cbc_encrypt.png", width: 70%)
  )

  #figure(
    image("images/cbc_encrypt.png", width: 70%)
  )

  - *Encryption:*
    - $C_i = E(K, P_i or C_(i - 1))$, where $C_0 = I V$ 
    - $P_i$ is `XOR`ed with the previous ciphertext block $C_(i - 1)$, and encrypted with the key $K$ to produce ciphertext block $C_i$. For the first plaintext block $I V$ is used for the value of $C_0$ 

  - *Decryption:*
    - $P_i = D(K, C_i) xor C_(i - 1)$
    - $C_i$ is decrypted with the $K$ ,and `XOR`ed with the previous ciphertext block $C_(i - 1)$ to produce plaintext block $P_i$. As in encyption, $I V$ is used in place of $C_0$ 

  *CBC Mode Error Propagation*

  #figure(
    image("images/cbc_error.png", width: 70%)
  )

]


#corollary(title: "CBC Mode Properties")[
    #figure(
    image("images/cbc_properties.png", width: 80%)
  )

  CBC mode is commonly used for bulk encryption and is supported in most libraries and protocols 
]

#definition(title: "Counter Mode (CTR)")[

  Choose a nonce at random during encryption. Prepend the nonce to the ciphertext


  #figure(
    image("images/ctr.png", width: 62%)
  )

  CTR is a synchronous stream cipher. The keystream is generated by encrypting successive values of a "counter", initialized using a nonce (randomly chosen value) $N$:

  
  $ O_i = E(K, T_i) $

  Where $T_i = N || i$ is the concatenation of the nonce and block number $i$

  - *Encryption:*
    - $C_i = O_i xor P_i$ 

  - *Decryption:* 
    - $P_i = O_i xor C_i$

  
  - One bit change in ciphertext produces a one bit change in the plaintext at the same location

]

#corollary(title: "CTR Mode Properties")[
  The underlying block cipher is only used in encryption mode.

  #figure(
    image("images/cbc_properties.png")
  )

  - CTR mode is a synchronous stream cipher mode 
  - CTR mode is also good for access to specific plaintext blocks without decrypting the whole stream 
]

#remark[
  *Summary of Mode Properties*

  #figure(
    image("images/properties_summary.png", width: 80%)
  )
  
  \* if receiver realizes bock has been dropped and advances appropriately 
]

#pagebreak()

== Hash Functions 

#linebreak()

#definition(title: "Hash Function")[

  - A hash function is a checksum designed to be sage from malicious tampering

  - $H$ is called an $n$-bit hash function 

  - $H(x)$ is called the hash value, hash, or message digest of $x$ 

  - Description of a hash function is public. There are no secret keys.

  A hash function is a mapping $H$ such that: 

  1. $H$ maps inputs of arbitrary lengths to outputs of length $n$, where $n$ is fixed ($H : {0, 1}* arrow {o, 1}^n)$ (more generally, $H$ maps elements of a set $S$ to a set $T$ where $|S| > |T|$)

  2. $H(x)$ can be efficiently computed for all $x in {0, 1}*$ 

]

#corollary(title: "Typical Cryptographic Requirements (Informally)")[
  - *Pre-image Resistance:* Hard to invert given just an output 
  - *2nd Pre-image Resistance:* Hard to find a second input that has the same hash value as a given first input 
  - *Collision Resistance:* Hard to find two different inputs that have the same hash values 
]

#definition(title: "Pre-image Resistance")[
  Let $m$ be a positive integer. We say that $H$ is _pre-image_ resistant for messages of length $m$ if, given $y = H(x)$ for $x$ picked uniformly at random from ${0, 1}^m$, it is computationally infeasible to find (with non-negligible success probability) any input $z$ such that $H(z) = y$

  - $z$ is called a pre-image of $y$ 
]

#definition(title: "Second Pre-image Resistance")[
  Let $m$ be a positive integer. We say that $H$ is second pre-image resistant for messages of length $m$ if, given an input $x in_R {0, 1}^m$, it is computationally infeasible (with non-negligible success probability) to find a second input $x' != x$ such that $H(x) = H(x')$

  - $x in_R {0, 1}^m$ means $x$ chosen uniformly at random from ${0, 1}^m$ 
]

#definition(title: "Collision Resistance")[
  It is computationally infeasible (with non-negligible success probability) to find two distinct input $x, x'$ such that $H(x) = H(x')$ 

  - The pair $(x, x')$ is called a collision for $H$ 
]

#remark[

  How are second pre-image resistance and collision resistance different?

  - *Collision Resistance:* The attacker has freedom to pick both $x$ and $x'$ 
  - *Second Pre-image Resistance:* The attacker given some $x$ and has to find an $x'$ 
]

#definition(title: "One Way Hash Function")[
  A has function that is pre-image resistant is sometimes called a one way hash function (OWHF)
]

#definition(title: "Cryptographic Hash Function")[
  A hash function that is pre-image, second pre-image, and collision resistant is called a cryptographic has function 
]

#linebreak()

#highlight[Some Applications of Hash Functions]

- *Password protection on a multi user computer system* 

- *Modification Detection Codes (MDC)* 
  - Ensure that a message $m$ is not modified by unauthorized means, one computes $H(m)$ and protects $H(m)$ for unauthorized modification 

- *Message Digest for Digital Signature Schemes*
  - For reasons of efficiency, instead of signing a (long) message, the (much shorter) message digest is signed  

- *Message Authentication Codes (MACs)* 
  - Provides data integrity and data origin authentication 

- *Pseudorandom Bit generation* 
  - Distilling random bits $s$ from several "random" sources $x_1, x_2, dots , x_t$ 

- *Key Derivation Function (KDF)* 
  - Deriving a cryptographic key from a shared secret 

#remark[
  Collision resistance is not always necessary 
]

#corollary(title: "Popular Hash Functions")[
  - MD5 
  - SHA-1
  - SHA-2
  - SHA-3 

  Less widely used: MD2, MD4, Tiger

  Not cryptographic hash functions: CRC8, CRC16, CRC32
]

#tip-box[
  In cryptography we often want to show theorems like:

  #theorem[
    If scheme $S$ satisfies security property $X$, then scheme $T$ (built using $S$) satisfies security property $Y$ 
  ]

  Or,
  
  #theorem[
    If there is no efficient adversary that breaks security property $X$ of scheme $S$, then there is no efficient adversary that breaks security property $Y$ of scheme $T$
  ]

  It is often more convenient to prove the (equivalent) *contrapositive statement*:

  #theorem(title: "Contrapositive Statement")[
    Suppose there exists an efficient adversary $B$ that breaks security property $Y$ of scheme $T$. 

    Then there exists an efficient adversary $A$ (that uses $B$) that breaks security property $X$ of scheme $S$
  ]

  To prove the contrapositive statement, our task is coming up with the algorithm $A$, assuming that algorithm $B$ exists with desired property 
]

We can take this and do $arrow$ 

#remark[
  #theorem[
    Collision resistance implies $2$nd pre-image resistance 
  ]
  
  Or,
  
  #theorem[
    If $H$ is collision resistant, then $H$ is $2$nd pre-image resistant 
  ]

  Written in the contrapositive form:

  #theorem[
    If there exists an efficient algorithm $B$ that breaks the $2$nd pre-image resistance of $H$, then there exists an efficient algorithm $A$ that breaks the collision resistance of $H$ 
  ]
]

#tip-box[
  In cryptography we sometimes want to show theorems like the following:

  #theorem[
    Security property $X$ does not imply security property $Y$ 
  ]

  Another way of phrasing this is: 

  #theorem[
    There exists a scheme $S$ that has security property $X$ but does not have security property $Y$ 
  ]

  Often we prove this by taking a generic scheme $S$ that has property $X$, then construct an "artificially degenerate" modified scheme $S^*$ that still has property $X$, but clearly doesn't have property $Y$  
]

#definition(title: "Generic Attacks")[
  - A generic attack on a has function $H : {0, 1}^* arrow {0, 1}^n$ does not exploit any properties a specific hash function may have 
  - In the analysis of a generic attack, we view $H$ as a random function the sense that for each $x in {0, 1}^*$, the value $y = H(x)$ was chosen by selecting $y$ uniformly at random from ${0, 1}^n$ (written $y in_R {0, 1}^n$)
  - From a security point of view, a random function is an ideal hash function. However, random functions are not suitable for practical applications because they cannot be compactly stored
]

#definition(title: "Generic Attack for Finding Pre-images")[
  Given $y in {0, 1}^n$, repeatedly select distinct $x' in {0, 1}^*$ until $H(x') = y$ 

  - Expected number of steps is $approx 2^n$ (each step is a hash function evaluation)
  - This attack is infeasible if $n => 128$ 
  - It is proven that this generic attack for finding pre-images is optimal 
]

#definition(title: "Generic Attack for Finding Collisions")[
  Repeatedly select arbitrary distinct $x in {0, 1}^*$ and store $(H(x), x)$ in a table sorted by first entry. Continue until a collision is found 

  - Expected number of steps is $sqrt((pi 2^n) / 2) approx sqrt(2^n)$ (birthday paradox) (each step is a hash function evaluation)
  - It is proven that this generic attack for finding collisions is optimal 
  - Expected space required:  $sqrt((pi 2^n) / 2) approx sqrt(2^n)$
  - This attack is infeasible if $n >= 160$ 
  - If $n = 128 $
    - Expected running time: $2^64$ steps (barely feasible)
    - Expected space required: $7 times 10^8$ Tbytes 
  
]

#theorem(title: "Birthday Paradox")[
  Suppose $q$ values are picked uniformly at random, with replacement, from a set of size $N$. Then the probability of no collisions among the $q$ selected values is 

  $ "Prob(no collision) " = product^(q - 1)_(i = 1) (1 - i / N) $

  Approximation used and generally good enough for class,

  $ "Prob(collision) " approx q^2 / N $ 
]

#definition(title: "The Merkle Damgard Construction")[
  To compute $H(m)$ where $m$ has bit length $b < 2^r$ do:
  
  1. Break up $m$ into $r$-bit blocks: $m^* = m_0, m_1, dots , m_(t - 1)$, padding out the last block with $0$ bits if necessary 

  2. Define $m_t$, the length block, to hold the right justified binary representation of $b$ 
  
  3. Define $H_0 = I V$ 

  4. Compute $H_(i + 1) = f(H_i, m_i)$ for $i = 0, 1, 2, dots , t$

  5. $H_i$'s are called chaining variables 

  6. return $H(m) = H_(t + 1)$ 

  #figure(
    image("images/merkle.png")
  )
]

#theorem(title: "Collision Resistance of Merkle Damgard")[
  If the compression function $f$ is collision resistant, then the hash function $H$ is also collision resistant
]

#definition(title: "SHA-2")[
  Description of SHA-256 (For SHA-384 and SHA-512, increase n to 512 and r to 1024):

  - Iterated hash function (Merkle Damgard construction)

  - $n = 256$ , $r = 512$ 

  - Compression function is $f : {0, 1}^(256 + 512) arrow {0, 1}^256$ 

  - Input: Bit string $x$ of arbitrary bit length $b >= 0$

  - Output: $256$-bit hash value $H(x)$ of $x$ 
]

#corollary(title: "Wangs Collision Finding Attack (SHA-1)")[
  - Fix any $n$-bit string $I$

  - Wangs attack finds two (different) 1 block messages $x = x_1$ and $y = y_1$ such that $F(I, x_1) = F(I, y_1)$ 
  
  - The attack gives limited but not complete control over $x_1$ and $y_1$ 

  - The attack takes about $2^63$ steps (versus usual $2^80$)

  - By selecting $I = I V$ (where $I V$ is the fixed initialization vector specified in SHA-1), Wang's attack can be used to find two one block messages $x$ and $y$, so these messages are essentially meaningless
]

#lemma(title: "How to Exploit Single Hash Collision")[
  
  - Let $H$ be a hash function 

  - Suppose that we can find two message $x$ and $y$ so that $H(x) = H(y)$ 

  - Suppose that the collision finding method we use does not allow us to control the structure of $x$ and $y$, so that these messages are essentially meaningless 
  
  - Suppose also that the collision finding methods take considerable (but feasible) time
]

#definition(title: "Sponge Function")[
  - *State:* $S in {0, 1}^b$ 
  - *Function $f$:* $f : {0, 1}^b arrow {0, 1}^b$, often a permutation 
  - A padding function 

  - The state $S$ is divided into two parts: $R in {0, 1}^r$ and $C in {0, 1}^c$ where $b = r + c$; $r$ is called the rate and $c$ is the capacity

  To hash a message $m$: 

  1. Initialize state $S = R || C$ to zero 
  2. Pad message to break into $r$-bit blocks
  3. [Absorb Stage] For each $r$-bit block $B$:
    - Replace $R arrow.l R xor B$ 
    - Replace $S arrow.l f(S)$ 
  4. [Squeeze Stage] While more outputs bits are needed: 
    - Output $R$ 
    - Replace $S arrow.l f(s)$


  #figure(
    image("images/sponge_function.png", width : 80%)
  )
]

#pagebreak()

=== Message Authentication Codes Authenticated Encryption

#linebreak()

#definition(title: "Message Authentication Code (MAC)")[
  A message authentication code (MAC) scheme is an efficiently computable function 

  $ M : {0, 1}^l times {0, 1}^* arrow {0, 1}^n $ 

  written 

  $ M(k, m) = t $ 

  Where $k$ is the key, $m$ is the message, and $t$ is the tag 

  #quote-box[
    MAC schemes are used for providing (symmetric key) data integrity and data origin authentication
  ]

  #figure(
    image("images/macs.png", width : 50%)
  )
]

#corollary(title: "Applications of Message Authentication Codes")[

  1. Alice and Bob establish a secret key $k in {0, 1}^l$ 

  2. Alice computes $t = M(k, m)$ and sends $(m, t)$ to Bob 

  3. Bob verifies that $t = M(k, m)$ 

  To avoid replay, add a timestamp, or sequence number 

  No confidentiality or non-repudiation 

  #figure(
    image("images/app_mac.png", width : 70%)
  )
]

#pagebreak()

Let $k$ be the secret key shared by Alice and Bob

The adversary knowns everything about the MAC scheme expect the value of $k$ 

#definition(title: "MAC security")[

  A MAC scheme is secure if: 

  - Given some number of MAC tags $M(k, m_i)$ for messages $m_i$ chosen adaptively by the adversary (interaction)

  - It is computationally infeasible (computational resources)

  - To compute (with non non-negligible probability of success) the value of $M(k, m)$ for any message $m != m_i$ (goal)

  In other words, a MAC scheme is secure if it is existentially unforgeable against chosen message attack 
]

#definition(title: "Generic Attacks")[

  *Guessing the MAC of a message $m$:*

  - Select $y in {0, 1}^n$ and guess that $M(k, m) = y$ 

  - Assuming that $M(k, .)$ is a random function, the probability of success is $1 / 2^n$ 

  - Guesses cannot be directly checked without interaction 

  - Depending on the application where the MAC algorithm is employed, one could choose $n$ as small as $32$. In general, $n => 128$ is preferred 

  *Exhaustive Search on the Key Space:*

  - Given $r$ known message-MAC pairs: $(m_1, t_1), dots , (m_r, t_r)$ one can check whether a guess $k$ of the key is correct by verifying that $M(k, m_i) = t_i$ for $i = 1, 2, dots , r$ 

  - Assuming that the $M(k, .)$'s are random functions, the expected number of keys for which the tags verify is $K + 2^l / 2^(n r)$ 

  - Requires $approx 2^l$ computations

  - Exhaustive search is feasible if $l >= 128$ 
  
]


#definition(title: "MACs based on has functions: Secret Prefix method")[
  
  MAC definition: $M(k, m) = H(K || m)$

  #figure(
    image("images/macs_secret.png")
  )

  This is insecure. Here is a length extension attack: 

  - Suppose that $(m, M(k, m))$ is known 
  - Suppose that the bit length of $m$ is a multiple of $r$ 
  - Then $M(k, m || m')$ can be computed for any $m'$ (without knowledge of $k$)

  Also insecure if a length block is post pended to $K||m$ prior to application of $H$
]


#definition(title: "Encrypt and MAC (E&M)")[

  Consider encrypt and MAC 

  $ "Compute " c = E n c (m) " and " t = M A C (m), " transmit " c || t $ 

  When decrypting, the recipient checks that the MAC is correct 

  - Problem: MAC's are not required to ensure confidentiality 
    - For example, the MAC might leak one plaintext bit, and still be "secure" as a MAC as. Violates semantic security!

  - Even if the SKES is secure and the MAC is secure, the encrypt and MAC combination might be insecure 
]

#definition(title: "MAC then encrypt (MtE")[

  Consider the MAC then encrypt 

  $ " Compute " t = M A C (m) " and " c = E n c (m || t) , " transmist " c $ 

  When decrypting, the recipient checks that the MAC is correct 

  - Problem: SKES's are not required to integrity 
    - For example, changing the ciphertext might not change the plainttext for certain values of plaintetxt. Violates integrity (of ciphertexts). (e.g. this does not MAC the IV)
    - One can often then also learn information about the plaintext 

  - Even if the SKES is secure and the MAC is secure, the MAC then encrypt combination might be insecure 
]

#definition(title: "First Class Primitives for Authentication Encryption")[

  The fastest way to achieve authenticated encryption is to use a block cipher mode of operation with authentication built in: 

  - CCM mode (counter with CBC MAC)
  - EAX mode 
  - GCM mode 
  - OCB mode 

  The modes of operation require a block cipher, but not a separate MAC (authentication functionality is built in) 
]

#definition(title: "Authenticated Encryption with Associated Data")[
  Common Scenario: Parts of a message must remain unencrypted, but still remain authenticated 

  Unencrypted data that travels with ciphertext = associated data 
]


#definition(title: "Authenticated Encryption with Associated Data (AHEAD)")[

  Goals: We have a message $m$ and some associated data $d$. We want to produce a cipher text $c$ and a tag $t$, such that: 

  - The ciphertext provides semantic security for the message $m$ 

  - The tag $t$ authenticates the message $m$ and the associated $d$ 

  - All of this is implemented in a dummy proof system

  To avoid combining secure encryption schemes and MACS and still getting and still getting insecure authenticated encryption schemes, we want non-experts to have a single function that does both 

]

#pagebreak()

=== Chosen Ciphertext Attacks 

#linebreak()

#definition(title: "Chosen Ciphertext Attacks")[

  One of our secondary goals in authenticated encryption is to prevent chosen ciphertext attacks. 

  Our goal is: 

  IND-CPA secure encryption + unforgeable MAC $arrow$ IND-CCA Secure encryption
]


#note-box[
  If we include a MAC of the ciphertext, then the adversary cannot modify the ciphertext without causing the MAC verification to fail.

  When the MAC verification fails, the adversary learns nothing from the decryption oracle.

  Thus, the adversary can only ask for decryption of ciphertexts it has previously encrypted – and the decryption oracle is useless.

  We can formalize this with a more sophisticated interactive security reduction proof.
]

=== Pseudorandom Functions

#definition(title: "Pseudorandom Generator")[
  A pseudorandom generator is a deterministic function that takes as input a uniform seed $k in {0 , 1}^l$ and outputs a random looking binary string of length $l$ 

  $ P R G : {0, 1}^l arrow {0, 1}^l $
]

#definition(title: "Pseudorandom Function")[

  A pseudorandom function is a determinism function that takes as input a uniform random seed $k in {0, 1}^l$ and a (non secret) label in ${0, 1}^*$ and outputs a random looking binary string of length $l$ 

  $ P R F : {0, 1}^l times {0, 1}^* arrow {0, 1}^l $ 
]

#definition(title: "Security Property for PRGs and PRFs")[

  *Indistinguishability:* 

  Assuming the seed is uniformly random on ${0, 1}^l$, it should be computationally infeasible for an adversary to distinguish the output of a PRG / PRF from a uniformly random string

  For PRGs, the adversary gets either the real output of PRG under an unknown seed, or a random output, and must decide which

  For PRFs, the adversary can make many calls to an oracle where the adversary can supply a label, and either always get the real output of the PRF using the same unknown seed applied to the label, or always gets a randomly chosen output (for distinct labels), and must decide which.

  PRGs and PRFs assume that the random seed is a truly random (uniform) secret 
]

#definition(title: "Key Derivation Function")[

  A key derivation function is a deterministic function that takes as input a (not necessarily uniform) random seed $k in {0, 1}^l$ and a (non-secret) label in ${0, 1}^*$ and outputs a random looking binary string of length $l$ 

  $ K D F : {0 , 1}^l times {0, 1}^* arrow {0, 1}^l $

]
 
#remark[
  *Difference between KDFs and PRFs:*

  KDF output should be indistinguishable from random even if the key $k$ is non-uniform but sufficiently high entropy
]

#corollary(title: "Uses of PRGs, PRFs, KDFs")[

  *PRGs:* Expanding a strong uniform short key into a long pseudorandom key (e.g. stream cipher)

  *PRFs:* Deriving many pseudorandom keys from a single short uniform key
  
  *KDFs:* Turning longer non-uniform keys into shorter uniform-ish keys 
]

#pagebreak()

=== Password Hashing 

#linebreak()

#definition(title: "User Authentication")[

  - Authenticators can be categorized as:
    - Knowledge based 
    - Object based 
    - ID based
    - Location based 

  - Multi factor authentication uses combinations from multiple different categories of authenticators 
]

#definition(title: "Entropy")[

  - Entropy measure the uncertainty in values generated from a random process 

  - Think of passwords being generated from a random process with a certain distribution 

  - Predicts the number of guesses we have to make to learn the password 

  - Suppose a process $X$ generates one of $n$ values of $x_1, dots , x_n$ with probabilities $p_1, dots, p_n$ 

  - Formula for entropy of process $X$:
    
  $ H(X) = - sum_(i = 1)^n p_i space l o g_2(p_i) $

  - Simple way of thinking about it:
    - If a password is chosen uniformly at random from a set of size $2^n$ 
    - Then its entropy $n$ bits
    - We require around $2^(n - 1)$ guesses on average to find it 

  - If some words are more likely than other there's less uncertainty 
    - $arrow$ less entropy 
    - $arrow$ easier to guess 
  
  - Entropy of passwords is a combination of length of password and randomness of each part of the password 
]

#definition(title: "Storing Passwords Securely")[

  1. Storing plaintext passwords in database 
    - Problem: You're cooked  

  2. Storing encrypted version of password in database
    - Problem: If someone learns the key, they can decrypt the whole database

  3. Store password using an irreversible transformation (hash)
    - Problem: None really- if someone forgets their password you cant recover it 
]

#corollary(title: "Password Hash Cracking")[
  - Attacking using Brute Force 
    - Slow and expensive

  - Attacking using Hash Tables
    - More difficult to crack one password has, but can reuse work (pre computation)
    - Requires massive amount of storage 

  - Attacking using Rainbow Tables (not on midterm hooray)
    - omitting for now

]

#definition(title: "Salting")[
  - *Registration:*
    - Pick a random $>= 80$-bit salt 
    - Store username, salt, and $H("password" || "salt")$ in database where $H$ is a cryptographic hash function 

  - *Login:*
    - User supplies username and purported password
    - Look up username, salt, and hash in database
    - Check if $H("password" || "salt") =$ stored hash
]

#corollary(title: "Benefits of Salting")[

  - Salting protects against precomputed hash tables / rainbow tables since you would need a different table for each salt

  - Salting doesn't make it harder to do a brute force search against a single hash 

  - Salting does make brute force attacks against many hashes harder because you can't reuse the work from one attack on another attach
]

#definition(title: "Password Hardening")[

  - You can slow down brute force attacks even more by hashing the password multiple times

  - Doesn't slow login much, but slows brute force by a factor of the number of times you hashed 
]

#pagebreak()

= Asymmetric Encryption

#linebreak()

#definition(title: "Symmetric Key Cryptography")[

  Communicating parties share a secret key 

]

#definition(title: "Establishment Problem")[

  How do two parties establish a secret key $k$ 

]

#corollary(title: "Point to Point Key Distribution")[

  $A$ selects a key $k$ and sends it to $B$ over a secure channel 
  
  Drawbacks:
    - Not scaleable 
]

#definition(title: "Use a Trusted Third Party (TTP) ")[

  - Each user $A$ shares a secret key $k_(A T)$ with $T$ for a symmetric key encryption scheme $E$ 
  - To establish this key, $A$ must vist $T$ once 
  - $T$ serves as a key distribution service

  #figure(
    image("images/KDC.png")
  )

  Drawbacks: 
    - The TTP must be unconditionally trusted
    - TTP is an attractive target 
    - TTP must be online 
]

#definition(title: "Key Management Problem")[

  - In a network of $n$ users, each user has to share a different key with every other user
  - Each user thus has to store $n - 1$ different secret keys 
  - The total number of secret keys is $"permutation"(n, 2) approx n^2 / 2$ 

]

#remark[
  Non-repudiation can't be achieved using symmetric techniques
  
  - Non-repudiation
    - Preventing an entity from denying previous actions or commitments.
    - Denying being the source of a message
]


