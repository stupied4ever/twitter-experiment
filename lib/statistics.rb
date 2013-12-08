class Statistics
  def initialize *categories
    @categories          = categories
    @retrieved_documents = Hash.new
  end

  def add_document id, actual, predicted
    @retrieved_documents.store id, { actual: actual, predicted: predicted }
  end

  def document id
    @retrieved_documents[id]
  end

  def true_positives category
    @retrieved_documents.values.select { |d|
      d[:actual] == category && d[:predicted] == category
    }
  end

  def true_negatives category
    @retrieved_documents.values.select { |d|
      d[:actual] != category && d[:predicted] != category
    }
  end

  def false_positives category
    @retrieved_documents.values.select { |d|
      d[:actual] != category && d[:predicted] == category
    }
  end

  def false_negatives category
    @retrieved_documents.values.select { |d|
      d[:actual] == category && d[:predicted] != category
    }
  end

  def total_true_positive category
    true_positives(category).count.to_f
  end

  def total_false_positive category
    false_positives(category).count.to_f
  end

  def total_true_negative category
    true_negatives(category).count.to_f
  end

  def total_false_negative category
    false_negatives(category).count.to_f
  end

  def total_documents
    @retrieved_documents.size.to_f
  end

  def accuracy category
    (
      total_true_positive(category) + total_true_negative(category)
    ) / total_documents
  end

  def recall category
    total_true_positive(category) / (
      total_true_positive(category) + total_false_negative(category)
    )
  end

  def precision category
    total_true_positive(category) / (
      total_true_positive(category) + total_false_positive(category)
    )
  end

  def f_score category
    precision(category) * recall(category) / (
      precision(category) + recall(category)
    )
  end

  def total_accuracy
    @categories.inject(0) { |sum, category|
      sum += accuracy(category)
    } / @categories.size
  end

  def total_recall
    @categories.inject(0) { |sum, category|
      sum += recall(category)
    } / @categories.size
  end

  def total_precision
    @categories.inject(0) { |sum, category|
      sum += precision(category)
    } / @categories.size
  end

  def total_f_score
    @categories.inject(0) { |sum, category|
      sum += f_score(category)
    } / @categories.size
  end
end
