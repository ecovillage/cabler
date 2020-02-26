module ApplicationHelper

  def nav_item_class(path)
    return "navbar-item #{active_class(path)}"
  end

  private

    def active_class(path)
      return 'is-active' if controller_name == path.remove('/')
    end

    def log(text)
      logger.debug(colored_string(text, {'r' => '255', 'g' => '20', 'b' => '90'}))
    end

    def colored_string(str, color)
      return "\u001b[38;2;#{color['r']};#{color['g']};#{color['b']}m#{str}\u001b[0m"
    end
end
