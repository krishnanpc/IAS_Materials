#Source http://ruder.io/optimizing-gradient-descent/index.html#gradientdescentvariants 

for i in range(nb_epochs):
  np.random.shuffle(data)
  for batch in get_batches(data, batch_size=50):
    params_grad = evaluate_gradient(loss_function, batch, params)
    params = params - learning_rate * params_grad
