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
  Idea: Modify Caeser cipher by introducing a secret key 

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
  Two perspevtives on a permutation 

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
    - Each subkey $k_i$ defines a component function $f_i : {0, 1}^l times {0, 1}^n arrow {0, 1}^n$

  - *Encryption takes $h$ rounds:*
    - Plaintext is $m = (m_0, m_1)$, where $m_i in {0, 1}^n$
    - *Round 1:* $(m_0, m_1) arrow (m_1, m_2)$, where $m_2 = m_0 xor f_1 (k_1, m_1)$
]



