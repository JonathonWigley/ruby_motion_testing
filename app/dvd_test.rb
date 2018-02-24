class DVDTest < SKScene
  include ScreenSizes

  attr_accessor :root

  # This method is invoked when a scene is presented.
  def didMoveToView view
    @dvd_logo = add_sprite device_screen_width.fdiv(2),
                          device_screen_height.fdiv(2),
                          'dvd.png',
                          'dvd'

    @dvd_logo_x = device_screen_width.fdiv(2)
    @dvd_logo_y =  device_screen_height.fdiv(2)
    @move_right = true
    @move_up = true
  end

  def update currentTime
    return if @dragging

    check_for_screen_edges

    @dvd_logo_x += 1 if @move_right
    @dvd_logo_y += 1 if @move_up
    @dvd_logo_x -= 1 if !@move_right
    @dvd_logo_y -= 1 if !@move_up

    @dvd_logo.position = CGPointMake(@dvd_logo_x, @dvd_logo_y)
  end

  def touchesBegan touches, withEvent: _
    @dragging = true
  end

  def touchesMoved touches, withEvent: _
    node = nodeAtPoint(touches.allObjects.first.locationInNode(self))

    if node.name == 'dvd'
      first_touch = touches.allObjects.first
      node.position = CGPointMake(first_touch.locationInNode(self).x, first_touch.locationInNode(self).y)
    end

  end

  def touchesEnded touches, withEvent: _
    first_touch = touches.allObjects.first
    @dvd_logo.position = CGPointMake(first_touch.locationInNode(self).x, first_touch.locationInNode(self).y)
    @dvd_logo_x = @dvd_logo.position.x
    @dvd_logo_y = @dvd_logo.position.y

    set_random_movement

    @dragging = false
  end

  def set_random_movement
    random = Random.new

    right = random.rand(2)
    up = random.rand(2)

    @move_right = false if right == 0
    @move_right = true if right == 1
    @move_up = false if up == 0
    @move_up = true if up == 1
  end

  def check_for_screen_edges
    if (@dvd_logo.size.width / 2.0) > (device_screen_width - @dvd_logo_x)
      @move_right = false
      @dvd_logo.color = get_random_color
      @dvd_logo.colorBlendFactor = 1.0
    end

    if (@dvd_logo.size.width / 2.0) > @dvd_logo_x
      @move_right = true
      @dvd_logo.color = get_random_color
    end

    if (@dvd_logo.size.height / 2.0) > (device_screen_height - @dvd_logo_y)
      @move_up = false
      @dvd_logo.color = get_random_color
    end

    if @dvd_logo.size.height / 2.0 > @dvd_logo_y
      @move_up = true
      @dvd_logo.color = get_random_color
    end
  end

  def get_random_color
    random = Random.new

    r = random.rand(256) / 256.0
    g = random.rand(256) / 256.0
    b = random.rand(256) / 256.0

    color = UIColor.colorWithRed(r, green: g, blue: b, alpha: 1.0)

    return color
  end

  def add_sprite x, y, path, name
    # Sprites are created using a texture. So first we have to create a
    # texture from the png in the /resources directory.
    texture = SKTexture.textureWithImageNamed path

    # Then we can create the sprite and set it's location.
    sprite = SKSpriteNode.spriteNodeWithTexture texture
    sprite.position = CGPointMake x, y
    sprite.size = CGSizeMake 150, 75
    sprite.name = name
    addChild sprite
    sprite
  end
end
