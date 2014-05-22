class IDEA::PostIdea

  def run(input)
    title = input[:title]
    desc = input[:description]
    cat = input[:category]
    if title.nil? || desc.nil? || cat.nil?
      return {
        success?: false,
        error: "Enter all require "

      }
