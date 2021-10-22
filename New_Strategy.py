# In[1]:

import numpy as np
import pandas as pd
import math


# In[2]:

## at every turn we know the life totals, cards in hand, number of creatures (tapped or untapped)

### life total stays the same (neutral), my life goes down (punished), their life goes down (rewarded)


### G1 Round 1 (End of the round)
#### Land for Turn (LFT) : TRUE or FALSE
#### Creatures Played : 0,1,2,...
#### self Life Total - 20,19,...,0
#### opponent Life Total - 20,19,...,0
#### List of spell targets - (self_tapped_creature, self untapped_creature, self_life, opponent_tapped_creature, opponent_untapped_creature, opponent_life) # append onto empty list
#### self_untapped_creature (board state)
#### opponent untapped_creature (board state)
#### self_tapped_creature (board state)
#### opponent_tapped_creature (board state)
#### creatures we attacked with
#### creatures opponent attacked with
#### creatures we blocked with
#### creatures opponent blocked with

game_history = pd.DataFrame(columns = ["Game","Round","LFT","CP","SLT", "OLT","ST","SUC","OUC","STC","OTC","SAC","OAC","SBC","OBC"])
game_history.set_index(['Game', 'Round'], inplace = True)
game_history.astype(dtype = {"LFT": bool, "CP" : int, "SLT": int, "OLT": int , "SUC": int,"OUC": int,"STC": int,"OTC": int,"SAC": int,"OAC": int,"SBC": int,"OBC": int})