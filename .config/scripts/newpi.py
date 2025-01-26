import pygame
from decimal import Decimal, getcontext

# Initialize Pygame
pygame.init()

# Set up display
screen_width = 800
screen_height = 200
screen = pygame.display.set_mode((screen_width, screen_height))
pygame.display.set_caption("Calculating Pi")

# Initialize font
font = pygame.font.Font(None, 24)

# Function to calculate Pi
def calculate_pi():
    getcontext().prec = 20000  # Set precision for calculations

    pi = Decimal(0)
    pi_string = "3."
    x_offset = 1000  # Initial offset for scrolling
    rendered_text_width = 0

    for k in range(20000):
        pi += (Decimal(1) / 16 ** k) * (
            Decimal(4) / (8 * k + 1) - Decimal(2) / (8 * k + 4) - Decimal(1) / (8 * k + 5) - Decimal(1) / (8 * k + 6)
        )
        
        pi_string += str(pi)[-1]  # Update the string representation of Pi
        pi_text = font.render(pi_string, True, (255, 255, 255))  # Render the Pi string

        # Calculate the width of the text
        text_width, _ = font.size(pi_string)
        
        # Update the screen with the text at the calculated offset
        screen.fill((0, 0, 0))  # Clear the screen
        screen.blit(pi_text, (screen_width // 2 - rendered_text_width, 50))  # Display Pi value with scrolling offset
        pygame.display.flip()  # Update display
        
        # Increment the rendered text width
        rendered_text_width += 1

        pygame.time.wait(5)  # Slower delay for visualization (adjust the value as needed)

    return pi

if __name__ == "__main__":
    # Call the function to calculate Pi
    pi = calculate_pi()

    # Keep the window open until the user closes it
    running = True
    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False

    pygame.quit()
    sys.exit()

