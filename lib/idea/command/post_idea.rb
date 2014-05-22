class IDEA::PostIdea

  def run(input)
    title = input[:title]
    desc = input[:description]
    cat = input[:category]
    if title.nil? || desc.nil? || cat.nil?
      return {
        success?: false,
        error: "Enter all require data"
      }
    end
    post = IDEA.db.crate_post(title: title, description: description, category: category)
    if post.nil? || post.id.nil? || post.title.nil? || post.description.nil?
      return {
        success?: false,
        error: "Your project idea post could not be created"
      }
    end

    categories.map! { |category| IDEA.db.get_or_create_category(category: category)}
     categories.each do |category|
      IDEA.db.create_post(post.id, category.id)
    end

    post.categorys = categories

    return {
      success?: true,
      post: post
    }
  end
end

