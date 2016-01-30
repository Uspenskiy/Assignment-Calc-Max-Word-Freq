class LineAnalyzer
  
  attr_reader  :highest_wf_count  #* - a number with maximum number of occurrences for a single word (calculated)
  attr_reader  :highest_wf_words  #* - an array of words with the maximum number of occurrences (calculated)
  attr_reader  :content           #* - the string analyzed (provided)
  attr_reader  :line_number       #* - the line number analyzed (provided)

  def initialize(text, lnumber)
    @content = text
    @line_number = lnumber
    @highest_wf_count = 0
    @highest_wf_words = Array.new
    calculate_word_frequency
  end

  def calculate_word_frequency()
    words = @content.downcase.split(/\W+/)
    for word1 in words
      count = 0
      for word2 in words
        if word1 == word2
          count += 1
          if count > @highest_wf_count
            @highest_wf_count = count
          end
        end
      end
    end
    for word1 in words
      count = 0
      for word2 in words
        if word1 == word2
          count += 1
          if count == @highest_wf_count
            until @highest_wf_words.include?(word1)
              @highest_wf_words << word1
            end
          end
        end
      end
    end
  end

end

class Solution

  attr_reader :analyzers
  attr_reader :highest_count_across_lines
  attr_reader :highest_count_words_across_lines

  def initialize
    @analyzers = Array.new
  end

  def analyze_file
    File.foreach('test.txt').with_index do |line, line_num|
      @analyzers << LineAnalyzer.new(line, line_num)
    end
  end

  def calculate_line_with_highest_frequency
    @highest_count_across_lines = 0
    @analyzers.each do |item|
      if item.highest_wf_count > @highest_count_across_lines
        @highest_count_across_lines = item.highest_wf_count
      end
    end
    @highest_count_words_across_lines = @analyzers.select { |item| item.highest_wf_count == @highest_count_across_lines }
  end

  def print_highest_word_frequency_across_lines
    @highest_count_words_across_lines.each do |item|
      result = '["' + item.highest_wf_words.join('", "') + '"]'
      result += '(appears in line ' +  item.line_number.to_s  + ' )'
      puts result
    end
  end
 
end
