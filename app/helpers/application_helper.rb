module ApplicationHelper

  def getNavItemClass(path)
    return "navbar-item #{addActiveClass(path)}"
  end

  private

    def addActiveClass(path)
      return 'is-active' if controller_name == path.remove('/')
    end

    def log(text)
      logger.debug(getColoredString(text, {'r' => '255', 'g' => '20', 'b' => '90'}))
    end

    def getColoredString(str, color)
      return "\u001b[38;2;#{color['r']};#{color['g']};#{color['b']}m#{str}\u001b[0m"
    end
end
