#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <portaudio.h>
#include <SDL2/SDL.h>

#define SAMPLE_RATE 44100
#define BUFFER_SIZE 512
#define SCREEN_WIDTH 800
#define SCREEN_HEIGHT 400
#define GRID_SPACING 50

float audioBuffer[BUFFER_SIZE];
int bufferIndex = 0;

// callback function
static int audioCallback(const void *inputBuffer, void *outputBuffer,
                         unsigned long framesPerBuffer,
                         const PaStreamCallbackTimeInfo *timeInfo,
                         PaStreamCallbackFlags statusFlags, void *userData) {
    if (inputBuffer != NULL) {
        const float *in = (const float *)inputBuffer;
        for (unsigned int i = 0; i < framesPerBuffer; i++) {
            audioBuffer[i] = in[i];
        }
    }
    return paContinue;
}

int main() {
    // Initialize SDL
    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        fprintf(stderr, "SDL could not initialize: %s\n", SDL_GetError());
        return 1;
    }
    SDL_Window *window = SDL_CreateWindow("Visify", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN);
    SDL_Renderer *renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
    
    // Initialize PortAudio
    Pa_Initialize();
    PaStream *stream;
    Pa_OpenDefaultStream(&stream, 1, 0, paFloat32, SAMPLE_RATE, BUFFER_SIZE, audioCallback, NULL);
    Pa_StartStream(stream);
    
    int running = 1;
    SDL_Event event;
    while (running) {
        while (SDL_PollEvent(&event)) {
            if (event.type == SDL_QUIT) {
                running = 0;
            }
        }
        
        // Clear screen
        SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
        SDL_RenderClear(renderer);
        
        SDL_SetRenderDrawColor(renderer, 0, 100, 0, 255);
        for (int x = 0; x < SCREEN_WIDTH; x += GRID_SPACING) {
            SDL_RenderDrawLine(renderer, x, 0, x, SCREEN_HEIGHT);
        }
        for (int y = 0; y < SCREEN_HEIGHT; y += GRID_SPACING) {
            SDL_RenderDrawLine(renderer, 0, y, SCREEN_WIDTH, y);
        }
        
        SDL_SetRenderDrawColor(renderer, 0, 255, 0, 255);
        for (int i = 1; i < BUFFER_SIZE; i++) {
            int x1 = (i - 1) * SCREEN_WIDTH / BUFFER_SIZE;
            int y1 = (SCREEN_HEIGHT / 2) + (int)(audioBuffer[i - 1] * (SCREEN_HEIGHT / 2));
            int x2 = i * SCREEN_WIDTH / BUFFER_SIZE;
            int y2 = (SCREEN_HEIGHT / 2) + (int)(audioBuffer[i] * (SCREEN_HEIGHT / 2));
            SDL_RenderDrawLine(renderer, x1, y1, x2, y2);
        }
        
        SDL_SetRenderDrawColor(renderer, 0, 255, 0, 255);
        SDL_Surface *surface = SDL_CreateRGBSurfaceWithFormat(0, SCREEN_WIDTH, SCREEN_HEIGHT, 32, SDL_PIXELFORMAT_RGBA32);
        SDL_FillRect(surface, NULL, SDL_MapRGBA(surface->format, 0, 0, 0, 0));
        SDL_Texture *texture = SDL_CreateTextureFromSurface(renderer, surface);
        SDL_FreeSurface(surface);
        SDL_Rect textRect = {10, SCREEN_HEIGHT - 20, 100, 20};
        SDL_RenderCopy(renderer, texture, NULL, &textRect);
        SDL_DestroyTexture(texture);
        
        SDL_RenderPresent(renderer);
        SDL_Delay(16);  // ~60 FPS
    }
    
    // Cleanup
    Pa_StopStream(stream);
    Pa_CloseStream(stream);
    Pa_Terminate();
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();
    return 0;
}
