class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add(:title, 'not valid') unless balanced?(record.title)
  end

  def balanced?(title)
    return false if title =~ /\(\)|\[\]|\{\}/

    paranthes_chars = {'(' => ')', '{' => '}', '[' => ']'}
    array_of_symbols = title.chars.select{ |char| paranthes_chars.to_a.flatten.include?(char) }

    return false if array_of_symbols.size.odd?

    stack = []

    until array_of_symbols.empty?
      if paranthes_chars.keys.include?(array_of_symbols.first)
        stack << array_of_symbols.shift
      else
        return false unless paranthes_chars[stack.pop] == array_of_symbols.shift
      end
    end

    true
  end
end
