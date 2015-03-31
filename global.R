library(data.table)

#-------------------------------------------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------------------------------------------#
# function to simulate the population in a given area
simPop <- function(N = 40000, n = 160, a = 1600, b = 1600){
  # data.table to contain the distribution of all people in a rectangular space
  # the is_participant flag is set to 0, no, for all people initially
  DT <- data.table(id = 1:N, x = runif(N , min = 0, max = a), y = runif(N , min = 0, max = b), is_participant = 0)
  setkey(DT, id)
  
  # select out n participants from the N 
  # make sure you set the seed here, since you would need the participants' ids to be the same always
  set.seed(123)
  DT[id == sample(1:N, n), is_participant := 1]
  return(DT)
}
#-------------------------------------------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------------------------------------------#
# funciton to simulate the motion of the population
movePop <- function(DT, p_Move = 0.25, iter = 1){
  DT.tmp <- copy(DT)
  # at a given time instance, selected in another algorithm, flip a coin to get the probability for
  # person i to move
  DT.tmp[, pMove := rbinom(nrow(DT), 1, p_Move)]
  DT.tmp[pMove == 1, c("x", "y") := 
           list((x + rnorm(length(id), 0, 1) * 5280 * 0.01 * iter), 
                (y + rnorm(length(id), 0, 1) * 5280 * 0.01 * iter))]
  return(DT.tmp)
}


#-------------------------------------------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------------------------------------------#
# function to get the number of closest neighbours within a given radius
countEnc <- function(x0 = 100, DT){
  # get distances and convert them into data.table. 
  # Do this only for active participants and not the whole population
  distDT <- as.data.table(as.matrix(dist(DT[ is_participant == 1, .(x,y)], diag = FALSE, upper = TRUE)))
  setnames(distDT, paste0("x", colnames(distDT)))
  setkey(distDT, x1)
  
  # number of participants
  nParticipants <- DT[is_participant == 1, length(id)]
  
  # vector to store number of encounters
  count <- numeric(length = nParticipants)
  
  # loop over participants and get the number of nearest neighbours within x0
  for (i in 1:nParticipants){
    rowName <- paste0("x", i)
    count[i] <- distDT[eval(parse(text = rowName)) <= x0 &  eval(parse(text = rowName)) != 0, length(eval(parse(text = rowName)))]
  }
  return(count)
}
#-------------------------------------------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------------------------------------------#

totalEnc <- function(DT, x0 = 100, iter = 8, ...){
  DT.tmp <- copy(DT)
  totalCount <- numeric(length = DT[is_participant == 1, length(id)])
  for(i in 1:iter){
    totalCount <- totalCount + countEnc(x0 = x0, DT = movePop(DT = DT, iter = iter, ...))
  }
  return(totalCount)
}



