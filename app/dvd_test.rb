class DVDTest
    include ScreenSizes

    attr_accessor :root

    def get_camera
        return @camera
    end

    def didMoveToView view
        self.scaleMode = SKSceneScaleModeAspectFit
        self.backgroundColor = UIColor.blackColor
        self.view.multipleTouchEnabled = true
    
        # Add instructions for this scene.
        add_label <<-HERE
        HERE

        @xPos = 100
        @yPos = 0
        @dvdLogo = add_sprite device_screen_width.fdiv(2),
                    device_screen_height.fdiv(2),
                    'button.png'
    end


    def update currentTime
        @xPos += 1
        @yPos += 1
    end

    def add_sprite x, y, path, name, parent
        texture = SKTexture.textureWithImageNamed path
        sprite = SKSpriteNode.spriteNodeWithTexture texture
        sprite.position = CGPointMake x, y
        sprite.name = name
        sprite.size = CGSizeMake(50, 50)
        anchorPoint = CGPointMake 0.5, 0.5
        parent.addChild sprite
        sprite
    end
end