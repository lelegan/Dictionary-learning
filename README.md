# Dictionary-learning

Implement Dictionary learning and train the Dictionaries to recognize capital letters from A to Z using Matlab. 
Data set: Chars74K
Each picture is reduce to size 20 by 20 using IrfanView64 software.

*The letter images are stored under the letter-set folder. 
*Capital letters are stored in the letter-set folders of those capital letter folders
*Small letters are stored in double-small-letter folders. 

*Note that although we have small letter data-set, this implementation does not include the small letters
to our testing yet.

To run through the implementation, simply use the file “main.m” and execute the code line by line in Matlab. The variable k is the default number of atoms in our dictionary, the variable lambda is the L1 norm regularization constant. And the variable “num-test-sets” means the current complete training set numbers. We currently have 26 capital letters, so we set it as
26.

References:
[Dictionary Learning and Sparse Coding for unsupervised clustering] (https://www.ima.umn.edu/sites/default/files/2281.pdf)
[Online Dictionary Learning for Sparse Coding] (http://www.di.ens.fr/~fbach/mairal_icml09.pdf)
