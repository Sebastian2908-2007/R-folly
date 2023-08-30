# Missing Title MORALITY TEST

# Author: Kelly Chase Offield
# Creation Date: 20 August 2023
# last edited: 28 August 2023

# This r-script reads through a spreadsheet (.xlsx) file and saves that "reading" into
# a dataframe ('QandA'). That dataframe represents the results of a morality test
# submitted by a person. In the test, certain questions/scenarios are put forth that
# the test subject answers. There is also a hidden "key" (QandA[c[n],1], or the c[nth]
# row and 1st collumn of QandA) in that test that represents the correct answers, which
# we will use to compare the person's answers to.

# We begin with the matrix below via the read_xlsx() function to create QandA from our
# .xlsx file. Of course, this is not our very first step because we need to make sure
# that we have that function, so we upload the libary 'readxl' first. We also need to
# set our working directory to the location on our computer where we will be reading
# this file and using this r-script. We then need to remove all user-saved variables.

#		rows
#
#
#
# 	QandA[1,...]		       x           x           x         ...
# 	QandA[2,...]		       x           x           x         ...
# 	QandA[3,...]		       x           x           x         ...
# 	QandA[4,...]		       x           x           x         ...
# 	QandA[5,...]		       x           x           x         ...
#  	QandA[6,...]		       x           x           x         ...
# 	QandA[7,...]		       x           x           x         ...
# 	QandA[8,...]		       x           x           x         ...
# 	QandA[9,...]		       x           x           x         ...
# 	QandA[10,...]		       x           x           x         ...
# 		:			   	       :		   :           :         ...
#
#
#
#						QandA[...,1]  QandA[...,2]  QandA[...,3]  ...		columns
                          ############user interacts with ROWS c =  17,32,47,62,77,92,107,122,137 AKA VAR c####################
# We need to reduce QandA into the important bits. The rows 17, 32, 47, 62, ... are 
# the rows in the file that the user interacts with and the rows where the answer key
# are saved. This r-script is not interested in other rows of data from the file. The
# 1st column is the column that the answer key is saved, so QandA[17,1] holds the
# correct answer for the 17th row of multiple choice, or question 1. The columns 3, 5,
# ..., 15 are the choices that the test taker has to choose from for each question.

# 	QandA[17,...]		       x           x           x           x         ...
# 	QandA[32,...]		       x           x           x           x         ...
# 	QandA[47,...]		       x           x           x           x         ...
# 	QandA[62,...]		       x           x           x           x         ...
# 	QandA[77,...]		       x           x           x           x         ...
#  	QandA[92,...]		       x           x           x           x         ...
# 	QandA[107,...]		       x           x           x           x         ...
# 	QandA[112,...]		       x           x           x           x         ...
# 	QandA[137,...]		       x           x           x           x         ...
# 	QandA[142,...]		       x           x           x           x         ...
# 		:			   	       :		   :           :           :         ...
#
#
#
#						QandA[...,1]  QandA[...,3]  QandA[...,5]  QandA[...,5]  ...

# Below is the matrix that holds the answer key. We include a sample of what that key
# may look like, where all possible answers are 1, 4, -4, or 7.

# 	QandA[17,1]		       1
# 	QandA[32,1]		       -4
# 	QandA[47,1]		       7
# 	QandA[62,1]		       1
# 	QandA[77,1]		       4
#  	QandA[92,1]		       1
# 	QandA[107,1]		   7
# 	QandA[112,1]		   -4
# 	QandA[137,1]		   4
# 	QandA[142,1]		   7
# 		:			   	   :
#
#					  QandA[...,1]

# If we can save the numerical sequence 17, 32, 47, 62, ... into a variable c. Then
# the answer key is simply QandA[c[n],1]

##########QandA[Row var[index]...]#######
####QandA[c[1],...]#######
# 	QandA[c[1],...]		       x
# 	QandA[c[2],...]		       x
# 	QandA[c[3],...]		       x
# 	QandA[c[4],...]		       x
# 	QandA[c[5],...]		       x
#  	QandA[c[6],...]		       x
# 	QandA[c[7],...]		       x
# 	QandA[c[8],...]		       x
# 	QandA[c[9],...]		       x
# 	QandA[c[10],...]	       x
# 		:			   	       :
#
#						QandA[c[n],1]

                  ############COLUMN MULT CHOICE ANSWERS b = 3,5,7,9,11,13,15#####################
# The columns 3, 5, 7, 9, ..., 15 are the multiple choice options for the questions.
# If we save that number sequence into b, then QandA[...,3] = QandA[...,b[1]0 and
# QandA[...,5] = QandA[...,b[2]], and so on. Thus, the matrix below is represented

#####QandA[Correct answers,user answers]#########
# as QandA[c[n],b[i]].

# 	QandA[c[1],...]		       x 				 x				 x            ...
# 	QandA[c[2],...]		       x 				 x				 x            ...
# 	QandA[c[3],...]		       x 				 x				 x            ...
# 	QandA[c[4],...]		       x 				 x				 x            ...
# 	QandA[c[5],...]		       x 				 x				 x            ...
#  	QandA[c[6],...]		       x 				 x				 x            ...
# 	QandA[c[7],...]		       x 				 x				 x            ...
# 	QandA[c[8],...]		       x 				 x				 x            ...
# 	QandA[c[9],...]		       x 				 x				 x            ...
# 	QandA[c[10],...]	       x 				 x				 x            ...
# 		:			   	       :				 :				 :			  ...
#
#
#
#						QandA[...,b[1]]  QandA[...,b[2]]  QandA[...,b[3]]   ...

# In essence, we need to compare the user's answers with the correct answers, or
# QandA[c[n],b[i]] and QandA[c[n],1]. The user's answers, QandA[c[n],b[i]] can only
# have one answer for each row (n), like a bubble answer quiz. We need to include
# error analysis for user errors in which a row is left blank or more than one 
# option is filled out. Thus, we have to 'loop through' each row of our QandA[c,b]
# matrix from 1 to length(c), which we define as 'n'. For each row, we have a counter
# 'x' that keeps track of how many (if at all) answers were given by the user for
# each row. Thus, we start with x = 0 for each 'for loop'. Given that the user
# correctly answers a row (and only once), we need to keep track of that answer. We
# do this with 'y'. Thus, for each row, y is compared with the answer key for that
# nth row, so QandA[c[n],1] == y(n).

# Correct answers are defined as 1, 4, & 7, though -4 is also added for scenarios
# in which the correct answer is the same as '4' but the reasoning differs. If the
# correct answer is 1, then that represents the leftmost possible answer of a row.
# if the correct answer is 7, then that represents the rightmost possible answer of
# a row. The answers 4 and -4 are the center answer. 

# '4' represents the scenario where neither the left or right options are inherently 
# evil, so if a user is inclined to the left side, he is displaying attempting to 
# impose obligations where obligations ought to not belong, or type B villainy. If the
# user is inclined to disagree with the right side, he is displaying a tendency to
# control other's property, which is a form of theft, or type A villainy.

# -4 represents the scenario where both the left and the right options are evil. If
# the user disagrees with the left villainy (forcing of obligations) more, then he
# tends to be "insulated" from the other villainy, or (neglect of obligations). Hence,
# he is displaying type A villainy. If the user disagrees with the right villainy (the
# neglection of legitimate obligations) more than the left, then vice versa.

# 	[-------------------------------------------------------------------]
# 	[---------------------------- Variables ----------------------------]
# 	[-------------------------------------------------------------------]

# QandA: a list variable of the data from our test subject file.
# b: ###MULTIPLE CHOICE ANSWER COLUMNS### a dataframe of the column numbers of QandA that correspond to the columns of 
#	questionaire choices
# n: n is the index across c, or the index for rows; the syntax is c[n]
# c: a dataframe of the row numbers of QandA that correspond to the answer rows, so 
#	QandA[c,1] should be the correct answers if they are in the first column. 
# i: i is the index across b, or the index for columns; the syntax is b[i]
# QandA[c[n],b[i]]: user's answers for specific question (7x1 dataframe from QandA) 
# QandA[c[n],1]: correct answer for specific question (the 1st column from a QandA row)
# x: a numerical value for number of answers (should be '1')
# y: a numerical value for which answer (should be within 1:7)
# typeA: villainy of the form: neglectful of legitimate obligations
# typeB: villainy of the form: forceful of illegitimate obligations
# t1: a fancy '1', of a 1x1 matrix where its single entry is '1'.
# t7: a fancy '7', of a 1x1 matrix where its single entry is '7'.
# t4: a fancy '4', of a 1x1 matrix where its single entry is '4'.
# tneg4: a fancy '-4', of a 1x1 matrix where its single entry is '-4'.
# difference: this is the numerical difference between correct and given answers.


# Below is the values 'y' associated with questionaire answers.
# If not empty, column [...,3] -> 1 	so y(3) = 1
# If not empty, column [...,5] -> 2 	so y(5) = 2
# If not empty, column [...,7] -> 3 	so y(7) = 3
# If not empty, column [...,9] -> 4 	so y(9) = 4
# If not empty, column [...,11] -> 5 	so y(11) = 5
# If not empty, column [...,13] -> 6 	so y(13) = 6
# If not empty, column [...,15] -> 7 	so y(15) = 7

# 	[-------------------------------------------------------------------]
# 	[---------------------------- Functions ----------------------------]
# 	[-------------------------------------------------------------------]

# library()		
# setwd()		
# rm()			
# ls()			
# read_xlsx()	
# seq()			
# print()		
# data.frame()	
# for()			
# length()		checks the length of an input
# is.na()		checks if an input is empty
# if()			
# abs()			

# 	[-------------------------------------------------------------------]
# 	[---------------------------- Operators ----------------------------]
# 	[-------------------------------------------------------------------]

# ! 
# == 
# <- 
# in 
# by 




# 	[-------------------------------------------------------------------]
# 	[------------------ Missing Title MORALITY TEST --------------------]
# 	[-------------------------------------------------------------------]
 #install.packages("readxl")
library("readxl") # we need this libary for the 'read_xlsx()' function
#getwd()
setwd("c:\\Users\\owner\\Desktop\\projects\\rmorality") # set the working directory

rm(list=ls(all=TRUE)) # remove all variables - start with a clean slate

QandA <- read_xlsx("testsubject.xlsx", col_names = FALSE, na="") # read our spreadsheet
	# file into a dataframe called 'QandA'.

	#	Initiate variables x, y, typeA, and typeB; define (b) a dataframe by the column
	#	numbers of QandA that correspond to the columns of questionaire choices; and 
	#	define (c) a dataframe by the row numbers corresponding to the answer rows of 
	#	QandA. Print those answers, or QandA[c,1].

x <- 0 # x is our counter, to make sure user answers only once.
y <- 0 # y is saved as the number i for the b[ith] row that the user answered
typeA <- 0 # need to start with a clean slate (and initialize our variable) for villain A
typeB <- 0 # need to start with a clean slate (and initialize our variable) for villain B
b <- seq(3, 15, by = 2) # b is the numbers representing answer columns of our file
c <- seq(17, 137, by = 15) # c is the numbers representing answer rows of our file
##print('here is your answer key') # ...to ensure the user did not tamper with the keys
##print(QandA[c,1]) # ...to ensure the user did not tamper with the keys
t1 <- data.frame(1) # used to compare user's answer 'y' with correct answer QandA[c[n],1]
t4 <- data.frame(4) # ...likewise
tneg4 <- data.frame(-4) # ...likewise
t7 <- data.frame(7) # ...likewise


####INITIAL OUTERMOST LOOP#######
####loop through answer rows####
for (n in 1:length(c)) {
	#	a For Loop across rows: to loop through each answer row of the questionaire:
	#	from 1 to length(c); or from 1 to the last question of the questionaire
	#	What follows will be for each n (1:length(c)); or each question row of QandA.
	
	x <- 0 # x is our counter, to make sure user answers only once.
	y <- 0 # y is the user's answer.
	QandA[c[n],b] # user's answers for specific question (7x1 dataframe from QandA)
	QandA[c[n],1] # correct answer for specific question (the 1st column from a QandA row)

##### 1ST NESTED LOOP
##loop through answer columns####
	for (i in 1:7){ 
		# a For Loop across columns: loop through the user's answers (b columns) in the nth row
                       ###loop Columns###
					   ######Whichever column holds the answer SAVE AS Y#######
					   print(b[2])
		if(!is.na(QandA[c[n],b[i]])){ #if a particular answer is not empty, do:
			x <- x + 1	# x is our counter, to make sure user answers only once.
			y <- i	# y is saved as the number i for the b[ith] row that the user answered
		}
	}

	if (x == 0) {print('please answer all questions')} # if the previous column loop does
		# not count a single non-empty row.


	if (x > 1) {print('only answer each question once')} # if the previous column loop
		# counts more than one non-empty row

###tRIGGERS TYPEB ADDITION######
	if (QandA[c[n],1] == t1) { # if the correct answer is t1, or the leftmost bubble:
		difference <- y - QandA[c[n],1] # take the difference
		typeB <- typeB + difference # and add that difference to typeB (type B villainy)
	}

### NEGATIVE FOUR OR -4 ASSOCIATED WITH TYPE B#############
	if (QandA[c[n],1] == t4) { # if the correct answer is t4, "niether bad" (center bubble):
		difference <- y - QandA[c[n],1] # take the difference
		if (difference < 0) { # if the difference is < 0, or user disagrees with someone doing 
				# some act that is not the user's business, then the user is displaying type B
				# villainy.
			typeB <- typeB + abs(difference) # add the difference to typeB
		}
		####ADDS TO TYPE A#####
		if (difference > 0) { # if the difference is > 0, or user feels compelled to control how
				# someone else uses their own property, then the user is displaying a form of
				# theft, or type A villainy. 
			typeA <- typeA + difference # add the difference to typeA
		}
	}

####ADDS TO TYPE A#####
	if (QandA[c[n],1] == t7) { # if the correct answer is t7, or the rightmost bubble:
		difference <- QandA[c[n],1] - y # take the difference
		typeA <- typeA + difference # add that difference to typeA since the user displays an
			# "insulation" to that form of villainy by not choosing t7.
	}


	if (QandA[c[n],1] == tneg4) { # if the correct answer is tneg4 "both scenarios are bad":
		difference <- y - abs(QandA[c[n],1]) # take the difference
		####ADDS TO TYPE A#####
		if (difference < 0) { # if the difference is < 0, the user is "insulated" from typeA
			typeA <- typeA + abs(difference) # add the difference to typeA
		}
		####ADDS TO TYPE B#####
		if (difference > 0) { # if the difference is > 0, the user is "insulated" from typeB
			typeB <- typeB + difference # add the difference to typeB
		}
		if (difference == 0) { # if the difference is = 0, the user answered in a balanced way
			typeB <- typeB # do nothing
			typeA <- typeA # do nothing
		}
	}
}

##print(typeA) # print the type A villainy score, or He-Who-Neglects-Legitimate-Obligations

##print(typeB) # print the type B villainy score, or He-Who-Forces-Illegitimate-Obligations

##print(difference)