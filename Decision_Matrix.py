#!/usr/bin/env python
# coding: utf-8

# # Strategy 1
# 
# This is the first strategy for the AI during the attack phase only. This strategy starts with a base of attacking with half of the available creatures (the first index of the matrix) rounded up. As each situation occurs the count will tick up for the particular situation, then if the AI wins the decision will increase the number of creatures to attack with by the count, with a cap of the number of creatures on the feild and if the AI loses it will decrease the number of creatures by the count with a minimum of 0 creatures.

# In[1]:


import numpy as np
import pandas as pd
import math


# In[2]:


#global variables
# Number of max creatures and life, can change to other variables
n = 21
global count_array
global decision_array
count_array = np.full((n,n,n,n), 0)
decision_array = np.full((n,n,n,n), 0.5)
for x in range(n):
    for y in range(n):
        for z in range(n):
            for a in range(n):
                decision_array[x,y,z,a] = int(math.ceil(x/2))
                
#defining decision function
def decision(count_array, self_creatures=0, opponent_creatures=0, self_life=20, opponent_life=20):
    attacking_creatures = decision_array[self_creatures, opponent_creatures, self_life, opponent_life]
    count_array[self_creatures, opponent_creatures, self_life, opponent_life] += 1
    count_array = count_array.astype(int)
    return int(attacking_creatures)

def reward(decision_array, count_array ,winner=None): #currently self = player 2, opponent = player 1
    count_array = count_array.astype(int)
    boolArr = count_array != 0 
    if winner == True:
        decision_array[boolArr] += count_array[boolArr]
        for i in range(n):
            np.clip(decision_array[i,:,:,:], 0, i, out = decision_array[i,:,:,:])
    else:
        decision_array[boolArr] = decision_array[boolArr] - count_array[boolArr]
        for i in range(n):
            np.clip(decision_array[i,:,:,:], 0, i, out = decision_array[i,:,:,:])
    decision_array = decision_array.astype(int)


# In[ ]:




