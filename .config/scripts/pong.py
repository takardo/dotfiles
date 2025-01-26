# Import the pygame library and initialise the game engine
import pygame
import random
import math
pygame.init()

# Define some colors
black = ( 0, 0, 0)
white = ( 255, 255, 255)
green = ( 0, 255, 0)
red = ( 255, 0, 0)

# Add a font to be used to show the score and any other text
font = pygame.font.SysFont(None, 48)

# Define whether to use full screen or not
fullScreen = False

# Variables to define sizes of the window and the paddles
screenWidth = 1280
screenHeight = 720
if fullScreen == True:
    #Grab the resolution of the display if needed
    screenWidth, screenHeight = pygame.display.Info().current_w, pygame.display.Info().current_h

# Variable to define frame rate
frameRate = 60

# Variables to store initial sizes and positions of the paddles and size of the ball
paddleHeight = screenHeight / 5
paddleWidth = screenWidth / 40
startingPaddleX = 10
startingPaddleY = (screenHeight / 2) - paddleHeight / 2
ballHeight = screenWidth / 50
ballWidth = screenWidth / 50

# Variables to store initial values for:
# * Paddle and ball velocities
# * Angle of the ball to move
# * Whether the ball should travel left to right and up or down (decided by either +1 or -1)
# * Height on the screen of each paddle (this references the top of the paddle)
# * Initial position for the ball
# * Initial score of zero for each player
paddleVelocity = 30
ballVelocity = 2
ballAngle = random.randint(30,60) / (180 / math.pi)
ballDirection = random.choice([-1,1])
ballDirectionX = ballDirection
ballDirectionY = ballDirection
leftPaddleHeight = startingPaddleY
rightPaddleHeight = startingPaddleY
ballPositionX = screenWidth / 2
ballPositionY = random.randint(0,screenHeight - int(ballHeight)+1)
leftPaddleScore = 0
rightPaddleScore = 0

# Open a new window and set to full screen if required
size = (screenWidth, screenHeight)
if fullScreen == True:
    screen = pygame.display.set_mode(size, pygame.FULLSCREEN)
else:
    screen = pygame.display.set_mode(size)

# Set the caption of the Window
pygame.display.set_caption("Pong")

#Define a class to create surfaces for the paddles and the ball
class Sprite(pygame.sprite.Sprite):
    def __init__(self, width, height, colour=white):
        super(Sprite, self).__init__()
        self.paddleWidth = width
        self.paddleHeight = height
        self.colour = colour
        self.image = pygame.Surface((self.paddleWidth, self.paddleHeight))
        self.image.fill(self.colour)
        self.rect = self.image.get_rect()

# The while loop will carry on until the user exits the game (e.g. clicks the close button or presses the escape key).
carryOn = True

# Frame counter variable to use to determine when each 10s or 60s period has passed
frameCount = 0

# The clock will be used to control how fast the screen updates
clock = pygame.time.Clock()

# Create the paddles and the ball objects
leftPaddle = Sprite(paddleWidth,paddleHeight)
rightPaddle = Sprite(paddleWidth,paddleHeight)
ball = Sprite(ballWidth,ballHeight,green)

# -------- Main Program Loop -----------
while carryOn:
    # Fill the screen with a black colour
    screen.fill(black)

    # Use the key.get_pressed() functionality to determine when keys are pressed down
    # this functionality works when keys are held down, whereas the pygame.KEYDOWN
    # demonstrated below only works each time the key is pressed
    keys=pygame.key.get_pressed()
    # When the s key is pressed
    if keys[pygame.K_s]:
        # Move the left paddle up
        leftPaddleHeight = leftPaddleHeight - paddleVelocity
        if leftPaddleHeight < 0:
            leftPaddleHeight = 0
    # When the x key is pressed    
    if keys[pygame.K_x]:
        # Move the left paddle down
        leftPaddleHeight = leftPaddleHeight + paddleVelocity
        if leftPaddleHeight > screenHeight - leftPaddle.paddleHeight:
            leftPaddleHeight = screenHeight - leftPaddle.paddleHeight
    # When the j key is pressed
    if keys[pygame.K_j]:
        # Move the right paddle up
        rightPaddleHeight = rightPaddleHeight - paddleVelocity
        if rightPaddleHeight < 0:
            rightPaddleHeight = 0  
    # When the n key is pressed
    if keys[pygame.K_n]:
        #Move the right paddle down
        rightPaddleHeight = rightPaddleHeight + paddleVelocity
        if rightPaddleHeight > screenHeight - rightPaddle.paddleHeight:
            rightPaddleHeight = screenHeight - rightPaddle.paddleHeight

    # Use the events framework to determine when the quit button is clicked and if the escape key is pressed
    for event in pygame.event.get(): # User did something
        if event.type == pygame.QUIT: # If user clicked close
            carryOn = False # Flag that we are done so we can exit the while loop
        if event.type == pygame.KEYDOWN:
            # When the a key is pressed
            if event.key == pygame.K_a:
                # Move the left paddle up
                leftPaddleHeight = leftPaddleHeight - paddleVelocity
                if leftPaddleHeight < 0:
                    leftPaddleHeight = 0    
            # When the z key is pressed    
            if event.key == pygame.K_z:
                # Move the left paddle down
                leftPaddleHeight = leftPaddleHeight + paddleVelocity
                if leftPaddleHeight > screenHeight - leftPaddle.paddleHeight:
                    leftPaddleHeight = screenHeight - leftPaddle.paddleHeight 
            # When the k key is pressed
            if event.key == pygame.K_k:
                # Move the right paddle up
                rightPaddleHeight = rightPaddleHeight - paddleVelocity
                if rightPaddleHeight < 0:
                    rightPaddleHeight = 0                       
            # When the m key is pressed
            if event.key == pygame.K_m:
                #Move the right paddle down
                rightPaddleHeight = rightPaddleHeight + paddleVelocity
                if rightPaddleHeight > screenHeight - rightPaddle.paddleHeight:
                    rightPaddleHeight = screenHeight - rightPaddle.paddleHeight
            # When the up arrow is pressed, increase the velocity of the paddle
            if event.key == pygame.K_UP:
                if paddleVelocity <= 100:
                    paddleVelocity += 0.2
            # When the down arrow is pressed, decrease the paddle velocity
            if event.key == pygame.K_DOWN:
                if paddleVelocity >= 1.2:
                    paddleVelocity -= 0.2
            # When the escape key is pressed quit the game
            if event.key == pygame.K_ESCAPE:
                carryOn = False
                
    #Make the ball move, based on the initial random values
    ballPositionX += ballDirectionX*ballVelocity*math.cos(ballAngle)
    ballPositionY += ballDirectionY*ballVelocity*math.sin(ballAngle) 
    
    #When the ball reaches an extremity at the top and bottom of the screen, we need to flip the direction
    if ballPositionY <= 0 or ballPositionY >= screenHeight - ballHeight:
        ballDirectionY *= -1

    #Now handle if the ball hits the left paddle
    if ballDirectionX == -1 and ballPositionX <= paddleWidth+startingPaddleX and ballPositionY >= leftPaddleHeight and ballPositionY <= leftPaddleHeight + leftPaddle.paddleHeight:
        ballDirectionX *= -1

    #Now handle if the ball hits the right paddle
    if ballDirectionX == 1 and ballPositionX >= screenWidth - paddleWidth-startingPaddleX-ballWidth and ballPositionY >= rightPaddleHeight and ballPositionY <= rightPaddleHeight + rightPaddle.paddleHeight:
        ballDirectionX *= -1

    #Now handle the scoring if the ball leaves the screen on the left and right side
    if ballPositionX <= 0:
        rightPaddleScore += 10
    
    if ballPositionX >= screenWidth:
        leftPaddleScore += 10

    # Construct a string to be displayed with the score for each player
    scoreString = f'Score: {leftPaddleScore}-{rightPaddleScore}'
    settingsString = f'Paddle Velocity: {round(paddleVelocity,1)} - Ball Velocity: {round(ballVelocity,1)} - PaddleSize: {round(leftPaddle.paddleHeight,1)}'

    # If the ball leaves the screen on the left or right hand side, set the position back to a random location
    # near the middle of the screen, with a random angle and moving in the opposite direction to the one it was
    # moving in when it left the screen
    if ballPositionX <= 0 or ballPositionX >= screenWidth:
        ballPositionX = screenWidth / 2
        ballPositionY = random.randint(0,screenHeight - int(ballHeight)+1)
        ballAngle = random.randint(30,60) / (180 / math.pi)
        ballDirection *= -1
        ballDirectionX = ballDirection
        ballDirectionY = ballDirection

    # Draw the paddles and ball on the screen in the updated positions
    screen.blit(leftPaddle.image,(startingPaddleX, leftPaddleHeight))
    screen.blit(rightPaddle.image,(screenWidth - paddleWidth - startingPaddleX, rightPaddleHeight))
    screen.blit(ball.image, (ballPositionX,ballPositionY))
    # Generate the text object to display the score and draw on the screen
    score = font.render(scoreString, True, red)
    screen.blit(score, ((screenWidth - score.get_rect().width)/2,10))
    settings = font.render(settingsString, True, red)
    screen.blit(settings, ((screenWidth - settings.get_rect().width)/2,screenHeight - settings.get_rect().height - 10))

    # Update the entire display
    pygame.display.update()

    # Every 10 seconds reduce the size of the paddle.
    # Perform the size adjustment if the frameCount is an integer multiple of 10 * the frame rate
    # Not the frameCount > 0, which ensures that the adjustment doesn't occur on the first frame drawn
    if frameCount > 0 and frameCount % (10*frameRate) == 0:
        # Only adjust the paddle to the height of the ball
        if leftPaddle.paddleHeight - paddleHeight / 10 >= ballHeight:
            # Decrement the size as stored in the leftPaddle object
            leftPaddle.paddleHeight -= paddleHeight / 10
            # Scale the paddle object using the pygame.transform.scale function and then store the image back in the leftPaddle object
            leftPaddle.image = pygame.transform.scale(leftPaddle.image, (paddleWidth, leftPaddle.paddleHeight))
        # As above, but for the right paddle
        if rightPaddle.paddleHeight - paddleHeight / 10 >= ballHeight:
            rightPaddle.paddleHeight -= paddleHeight / 10
            rightPaddle.image = pygame.transform.scale(rightPaddle.image, (paddleWidth, rightPaddle.paddleHeight))

    # Every 60 seconds increase the speed of the ball
    # Perform the size adjustment if the frameCount is an integer multiple of 60 * the frame rate
    # Not the frameCount > 0, which ensures that the adjustment doesn't occur on the first frame drawn
    if frameCount > 0 and frameCount % (60*frameRate) == 0:
        ballVelocity += ballVelocity / 10

    # Increase the frame counter, which is used for determining each 10s and 60s period
    frameCount += 1

    # Set the frame rate
    clock.tick(frameRate)
     
# Once we have exited the main program loop we can stop the game engine:
pygame.quit()