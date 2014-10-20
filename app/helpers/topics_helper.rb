module TopicsHelper
  def topic_last_path(topic)
    topic_path(topic, page: (topic.total_pages if topic.total_pages > 1), anchor: (topic.comments_count if topic.comments_count > 0))
  end

  def posted_count(user)
    if login?
      user.topics.count
    end
  end

  def accepted_count(user)
    if login?
      count = 0
      user.like_topics.each do|t|
        done = false
        t.comments.each do|c|
          if c.user == user and c.likes_count > 0
            done = true
            break
          end
        end
        count += 1 if !done
      end
      count
    end
  end

  def done_count(user)
    if login?
      count = 0
      user.like_topics.each do|t|
        done = false
        t.comments.each do|c|
          if c.user == user and c.likes_count > 0
            done = true
            break
          end
        end
        count += 1 if done
      end
      count
    end
  end
end
