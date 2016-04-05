no_dims = 2;
initial_dims = 50;
perplexity = 30;

mappedX = tsne(features, [], no_dims, initial_dims, perplexity);
gscatter(mappedX(:, 1), mappedX(:, 2), labels);