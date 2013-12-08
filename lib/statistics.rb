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
    }.count.to_f
  end

  def true_negatives category
    @retrieved_documents.values.select { |d|
      d[:actual] != category && d[:predicted] != category
    }.count.to_f
  end

  def false_positives category
    @retrieved_documents.values.select { |d|
      d[:actual] != category && d[:predicted] == category
    }.count.to_f
  end

  def false_negatives category
    @retrieved_documents.values.select { |d|
      d[:actual] == category && d[:predicted] != category
    }.count.to_f
  end

  def total_documents
    @retrieved_documents.size.to_f
  end

  def accuracy category
    (
      true_positives(category) + true_negatives(category)
    ) / total_documents
  end

  def recall category
    true_positives(category) / (
      true_positives(category) + false_negatives(category)
    )
  end

  def precision category
    true_positives(category) / (
      true_positives(category) + false_positives(category)
    )
  end

  def f_score category
    precision(category) * recall(category) / (
      precision(category) + recall(category)
    )
  end

  def total_true_positive
    @categories.inject(0) { |sum, category|
      sum += true_positives(category)
    } / @categories.size
  end

  def total_false_positive
    @categories.inject(0) { |sum, category|
      sum += false_positives(category)
    } / @categories.size
  end

  def total_true_negative
    @categories.inject(0) { |sum, category|
      sum += true_negatives(category)
    } / @categories.size
  end

  def total_false_negative
    @categories.inject(0) { |sum, category|
      sum += false_negatives(category)
    } / @categories.size
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

  def total_matthews_correlation
    (
      (total_true_positive * total_true_negative) -
      (total_false_positive * total_false_negative)
    )/ Math.sqrt(
      (total_true_positive + total_false_positive) *
      (total_true_positive + total_false_negative) *
      (total_true_negative + total_false_positive) *
      (total_true_negative + total_false_negative)
    )
  end
end
