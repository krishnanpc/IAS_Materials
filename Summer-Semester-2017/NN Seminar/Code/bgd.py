#Source http://ruder.io/optimizing-gradient-descent/index.html#gradientdescentvariants

for i in range(nb_epochs):
  params_grad = evaluate_gradient(loss_function, data, params)
  params = params - learning_rate * params_grad
