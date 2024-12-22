import pygame
import sys
import os

# Suppress terminal output
sys.stdout = open(os.devnull, 'w')
sys.stderr = open(os.devnull, 'w')

# Initialize Pygame
pygame.init()

# Set up display
screen_width = 450
screen_height = 450
screen = pygame.display.set_mode((screen_width, screen_height))
pygame.display.set_caption("Bouncing Ball Simulation")

# Colors
BLACK = (0, 0, 0)
GREEN = (0, 255, 0)

colors = [
    (255, 0, 0), (255, 165, 0), (255, 255, 0), (0, 255, 0),
    (0, 0, 255), (128, 0, 128), (0, 128, 128), (255, 192, 203),
    (255, 99, 71), (255, 69, 0), (0, 128, 0), (255, 0, 255),
    (173, 216, 230), (255, 255, 255), (128, 128, 0), (0, 128, 128),
    (255, 69, 0), (255, 215, 0), (218, 112, 214), (0, 255, 255),
    (0, 255, 0)
]

# Constants
gravity = 0.125

# Ball properties
ball_radius = 11

# Circle properties
circle_radius = 200
circle_color = GREEN
circle_center = (screen_width // 2, screen_height // 2)

# Initialize ball position to None
ball_pos = None

# Ball velocity (set to [2, 0] initially)
ball_vel = [1, 0]

# Momentum multiplier
momentum_multiplier = 1.01

# Initialize simulation start flag
simulation_started = False

# Initialize font
font = pygame.font.Font(None, 36)

# Create text surface and rectangle
text = font.render('Click inside the circle to start', True, GREEN)
text_rect = text.get_rect(midbottom=(circle_center[0], circle_center[1] + circle_radius +  50))

def reset_simulation():
    global ball_pos, ball_vel, current_color, simulation_started
    ball_pos = None
    ball_vel = [1, 0]
    simulation_started = False
    current_color = None

# Initialize hit counter
hit_counter = 0

# Initialize trail list
trail = []

# Initialize color index
color_index = 0

# Clock for controlling frame rate
clock = pygame.time.Clock()

# Main game loop
while True:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()

        if event.type == pygame.MOUSEBUTTONDOWN:
            mouse_x, mouse_y = pygame.mouse.get_pos()
            distance = ((mouse_x - circle_center[0]) ** 2 + (mouse_y - circle_center[1]) ** 2) ** 0.5
            if distance <= circle_radius:
                if simulation_started:
                    reset_simulation()
                else:
                    ball_pos = [mouse_x, mouse_y]
                    ball_vel = [0, 2]
                    current_color = colors[color_index]
                    color_index = (color_index + 1) % len(colors)
                    simulation_started = True

    if ball_pos is not None:
        ball_vel[1] += gravity
        ball_pos[0] += ball_vel[0]
        ball_pos[1] += ball_vel[1]

        if ball_pos[0] - ball_radius <= 0 or ball_pos[0] + ball_radius >= screen_width:
            ball_vel[0] = -ball_vel[0]
            ball_vel[0] *= momentum_multiplier
            current_color = colors[color_index]
            color_index = (color_index + 1) % len(colors)

        if ball_pos[1] - ball_radius <= 0 or ball_pos[1] + ball_radius >= screen_height:
            ball_vel[1] = -ball_vel[1]
            ball_vel[1] *= momentum_multiplier
            current_color = colors[color_index]
            color_index = (color_index + 1) % len(colors)

        distance = ((ball_pos[0] - circle_center[0]) ** 2 + (ball_pos[1] - circle_center[1]) ** 2) ** 0.5
        if distance > circle_radius - ball_radius:
            norm_vector = [(ball_pos[0] - circle_center[0]) / distance,
                           (ball_pos[1] - circle_center[1]) / distance]
            ball_pos[0] = int(circle_center[0] + norm_vector[0] * (circle_radius - ball_radius))
            ball_pos[1] = int(circle_center[1] + norm_vector[1] * (circle_radius - ball_radius))
            dot_product = 2 * (ball_vel[0] * norm_vector[0] + ball_vel[1] * norm_vector[1])
            ball_vel[0] -= dot_product * norm_vector[0]
            ball_vel[1] -= dot_product * norm_vector[1]
            ball_vel[0] *= momentum_multiplier
            ball_vel[1] *= momentum_multiplier
            current_color = colors[color_index]
            color_index = (color_index + 1) % len(colors)
            hit_counter += 1

        trail.append((ball_pos.copy(), current_color))

        if len(trail) > 100:
            trail.pop(0)

    screen.fill(BLACK)
    pygame.draw.circle(screen, circle_color, circle_center, circle_radius, 2)

    if ball_pos is not None:
        for pos, color in trail:
            pygame.draw.circle(screen, color, (int(pos[0]), int(pos[1])), ball_radius)

    if not simulation_started:
        screen.blit(text, text_rect)

    pygame.display.flip()

    clock.tick(60)
