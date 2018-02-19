class DVDTest < SKScene
  include ScreenSizes

  attr_accessor :root

  # This method is invoked when a scene is presented.
  def didMoveToView view
    @dvdLogo = add_sprite device_screen_width.fdiv(2),
                          device_screen_height.fdiv(2),
                          'dvd.png'

    @dvdLogoX = device_screen_width.fdiv(2)
    @dvdLogoY =  device_screen_height.fdiv(2)
    @moveRight = true
    @moveUp = true
  end

  def update currentTime
    checkForScreenEdges

    @dvdLogoX += 1 if @moveRight
    @dvdLogoY += 1 if @moveUp
    @dvdLogoX -= 1 if !@moveRight
    @dvdLogoY -= 1 if !@moveUp

    @dvdLogo.position = CGPointMake(@dvdLogoX, @dvdLogoY)
  end

  def checkForScreenEdges
    if (@dvdLogo.size.width / 2.0) > (device_screen_width - @dvdLogoX)
      @moveRight = false
      @dvdLogo.color = getRandomColor
      @dvdLogo.colorBlendFactor = 1.0
    end

    if (@dvdLogo.size.width / 2.0) > @dvdLogoX
      @moveRight = true
      @dvdLogo.color = getRandomColor
    end

    if (@dvdLogo.size.height / 2.0) > (device_screen_height - @dvdLogoY)
      @moveUp = false
      @dvdLogo.color = getRandomColor
    end

    if @dvdLogo.size.height / 2.0 > @dvdLogoY
      @moveUp = true
      @dvdLogo.color = getRandomColor
    end
  end

  def getRandomColor
    random = Random.new

    r = random.rand(256) / 256.0
    g = random.rand(256) / 256.0
    b = random.rand(256) / 256.0

    color = UIColor.colorWithRed(r, green: g, blue: b, alpha: 1.0)

    return color
  end

  def add_sprite x, y, path
    # Sprites are created using a texture. So first we have to create a
    # texture from the png in the /resources directory.
    texture = SKTexture.textureWithImageNamed path

    # Then we can create the sprite and set it's location.
    sprite = SKSpriteNode.spriteNodeWithTexture texture
    sprite.position = CGPointMake x, y
    sprite.size = CGSizeMake 150, 75
    addChild sprite
    sprite
  end
end
