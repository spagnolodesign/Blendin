require 'compass'

class TagTinter
  def initialize(base, tint)
    @base, @tint = base, tint
  end

  def update_tints
    User.tag_counts_on(:tags).each do |tag|
      percent = calculate_percentage(tag.count)
      tag.tint = evaluate("mix(#{@base}, #{@tint}, #{percent})")
      tag.save
    end
  end

  private

  def calculate_percentage(count)
    total = User.tag_counts_on(:tags).map(&:count).inject(:+)
    ((count * 100) / total).round(2)
  end

  def evaluate(value)
    Sass::Script::Parser.parse(value, 0, 0).perform(Sass::Environment.new).to_s
  end
end