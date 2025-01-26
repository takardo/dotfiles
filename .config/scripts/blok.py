import pybullet as p
import pybullet_data
import time

# Initialize PyBullet
p.connect(p.GUI)
p.setAdditionalSearchPath(pybullet_data.getDataPath())  # Load PyBullet assets
p.setGravity(0, 0, -9.8)

# Create a ground plane
plane_id = p.loadURDF("plane.urdf")

# Function to add a block
def add_block(position, size=(1, 1, 1)):
    visual_shape_id = p.createVisualShape(
        shapeType=p.GEOM_BOX, halfExtents=size
    )
    collision_shape_id = p.createCollisionShape(
        shapeType=p.GEOM_BOX, halfExtents=size
    )
    block_id = p.createMultiBody(
        baseMass=1,  # Set mass to make it dynamic
        baseCollisionShapeIndex=collision_shape_id,
        baseVisualShapeIndex=visual_shape_id,
        basePosition=position,
    )
    return block_id

# Create some blocks
block_ids = []
for i in range(5):
    block_ids.append(add_block((0, 0, i * 1.1)))  # Stack blocks vertically

# Function to throw a ball
def throw_ball(position, velocity, radius=0.5):
    visual_shape_id = p.createVisualShape(
        shapeType=p.GEOM_SPHERE, radius=radius
    )
    collision_shape_id = p.createCollisionShape(
        shapeType=p.GEOM_SPHERE, radius=radius
    )
    ball_id = p.createMultiBody(
        baseMass=1,
        baseCollisionShapeIndex=collision_shape_id,
        baseVisualShapeIndex=visual_shape_id,
        basePosition=position,
    )
    p.resetBaseVelocity(ball_id, linearVelocity=velocity)
    return ball_id

# Main simulation loop
while True:
    p.stepSimulation()

    # Example: Throw a ball after a few seconds
    if p.getRealTimeSimulation() > 5:
        throw_ball((2, 0, 2), (-10, 0, 0))  # Ball position and velocity

    time.sleep(1 / 240)  # Match PyBullet's simulation rate
