if __name__ == '__main__':

    tokenizer = nltk.data.load('tokenizers/punkt/english.pickle')



    # ****** Split the labeled and unlabeled training sets into clean sentences
    #
    sentences = []  # Initialize an empty list of sentences

    print "Parsing sentences from training set"
    for review in train["review"]:
        sentences += KaggleWord2VecUtility.review_to_sentences(review, tokenizer)

    print "Parsing sentences from unlabeled set"
    for review in unlabeled_train["review"]:
        sentences += KaggleWord2VecUtility.review_to_sentences(review, tokenizer)

    # ****** Set parameters and train the word2vec model
    #
    # Import the built-in logging module and configure it so that Word2Vec
    # creates nice output messages
    logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s',\
        level=logging.INFO)

    # Set values for various parameters
    num_features = 300    # Word vector dimensionality
    min_word_count = 40   # Minimum word count
    num_workers = 4       # Number of threads to run in parallel
    context = 10          # Context window size
    downsampling = 1e-3   # Downsample setting for frequent words

    # Initialize and train the model (this will take some time)
    print "Training Word2Vec model..."
    model = Word2Vec(sentences, workers=num_workers, \
                size=num_features, min_count = min_word_count, \
                window = context, sample = downsampling, seed=1)

    model.init_sims(replace=True)

    # It can be helpful to create a meaningful model name and
    # save the model for later use. You can load it later using Word2Vec.load()
    model_name = "model"
    model.save(model_name)
