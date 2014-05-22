class IDEA::SearchPostByCategory

  def run(input)
    category = input[:category]
    if category.nil? || category.empty?
      return {
        success?: false,
        error: "Catageory name was missing"
      }
    end
    cat_obj = IDEA.db.get_or_create_category(category: category)
    if cat_obj.nil?
      return {
        success?: false,
        error: "Category can not be created"
      }
    end
    posts = IDEA.db.get_post_from_category(cat_obj.id)
    if posts.empty?
      return {
        success?: false,
        error: "Couldn't find any category "
      }
    else
      return {
        success?: true,
        posts: posts
      }
    end
  end
end
