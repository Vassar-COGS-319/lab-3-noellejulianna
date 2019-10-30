# model selection ####

# suppose we have data from an experiment like this:
# mean RT correct = 250ms
# mean RT incorrect = 246ms
# accuracy = 0.80

# try to fit this data with both models by adjusting the parameters of the model
# HINT: you can speed up your parameter search by using a small number of samples
# initially, and then increasing the samples as you get closer to a viable set
# of parameters.
# 2nd HINT: Don't adjust the sdrw parameter of the random.walk.model or the criterion
# paramter of the accumulator model.

# You don't need to get a perfect match. Just get in the ballpark. 

## RANDOM WALK
rand.test <- random.walk.model(1000, drift=0.012, sdrw=0.3, criterion=4.90)
sum(rand.test$correct) / length(rand.test$correct) # should be close to 0.8

rand.correct.rt <- rand.test %>% filter(correct==TRUE) %>% select(rt) %>% unlist()
mean(rand.correct.rt) # should be about 250 ms

rand.incorrect.rt <- rand.test %>% filter(correct==FALSE) %>% select(rt) %>% unlist()
mean(rand.incorrect.rt) # should be about 246 ms

## ACCUMULATOR
accum.test <- accumulator.model(1000, rate.1 = 85, rate.2 = 92, criterion = 3)
sum(accum.test$correct) / length(accum.test$correct) # should be close to 0.8

accum.correct.rt <- accum.test %>% filter(correct==TRUE) %>% select(rt) %>% unlist()
mean(accum.correct.rt) # should be about 250 ms

accum.incorrect.rt <- accum.test %>% filter(correct==FALSE) %>% select(rt) %>% unlist()
mean(accum.incorrect.rt) # should be about 246 ms


# Can both models do a reasonable job of accounting for the mean RT and accuracy? Report the
# results of your efforts:

# Random:
# Accuracy = 0.813
# Correct Mean = 249.21
# Incorrect Mean = 245.12
# 
# Accumulator:
# Accuracy = 0.809
# Correct Mean = 251.99
# Incorrect Mean = 260.54
# 
# Yes, both models can do a reasonable job of accounting for mean and accuracy, although the relationship
# between Correct:Incorrect, wherein incorrect is slightly lower than correct was not a consistent result.

# Using the parameters that you found above, plot histograms of the distribution of RTs
# predicted by each model. Based on these distributions, what kind of information could
# we use to evaluate which model is a better descriptor of the data for the experiment?
# Describe briefly how you might make this evaluation.

correct.data <- rand.test %>% filter(correct==TRUE)
incorrect.data <- initial.test %>% filter(correct==FALSE)

layout(matrix(1:4, nrow=2, byrow=T))
hist(rand.correct.rt, main = 'Random Walk Model - Correct', xlab = 'Correct Mean Reaction Time')
hist(rand.incorrect.rt, main = 'Random Walk Model - Incorrect', xlab = 'Incorrect Mean Reaction Time')
hist(accum.correct.rt, main = 'Accumulator Model - Correct', xlab = 'Correct Mean Reaction Time')
hist(accum.incorrect.rt, main = 'Accumulator Model - Incorrect', xlab = 'Incorrect Mean Reaction Time')

# Based on the comparison of these histograms, it seems that the Accumulator Model produces more consistent
# results, keeping it within a tighter range of possible outcomes, whereas the Random Walk Model produces more
# extreme outcomes. This is likely a result of its randomness, making it possible for such extreme cases.
# Of course this judgement also depends on the intent of the person using it, whether they need
# an estimate of the most likely outcomes or a record of every single possible outcome, even the most extreme ones.
# The Random Walk model also tends to be more right skewed than the Accumulator Model
