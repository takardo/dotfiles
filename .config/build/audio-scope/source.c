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
                             if (SDL_Init(SDL_INIT_VIDEO) < 0) {
                                 fprintf(stderr, "SDL could not initialize: %s\n", SDL_GetError());
                                 return 1;
                             }

                             SDL_Window *window = SDL_CreateWindow("Visify", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED,
                                                                   SCREEN_WIDTH, SCREEN_HEIGHT,
                                                                   SDL_WINDOW_SHOWN | SDL_WINDOW_RESIZABLE);
                             if (!window) {
                                 fprintf(stderr, "Window creation failed: %s\n", SDL_GetError());
                                 SDL_Quit();
                                 return 1;
                             }
                             SDL_Renderer *renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);


                             Pa_Initialize();
                             PaStream *stream;
                             Pa_OpenDefaultStream(&stream, 1, 0, paFloat32, SAMPLE_RATE, BUFFER_SIZE, audioCallback, NULL);
                             Pa_StartStream(stream);

                             int running = 1;
                             SDL_Event event;
                             float gain = 10.0f;  // gain multiplier to amplify waveform visually

                             while (running) {
                                 while (SDL_PollEvent(&event)) {
                                     if (event.type == SDL_QUIT) {
                                         running = 0;
                                     }
                                 }

                                 int width, height;
                                 SDL_GetWindowSize(window, &width, &height);

                                 // Clear screen
                                 SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
                                 SDL_RenderClear(renderer);

                                 // Draw grid
                                 SDL_SetRenderDrawColor(renderer, 0, 100, 0, 255);
                                 for (int x = 0; x < width; x += GRID_SPACING) {
                                     SDL_RenderDrawLine(renderer, x, 0, x, height);
                                 }
                                 for (int y = 0; y < height; y += GRID_SPACING) {
                                     SDL_RenderDrawLine(renderer, 0, y, width, y);
                                 }

                                 // Draw waveform
                                 SDL_SetRenderDrawColor(renderer, 0, 255, 0, 255);
                                 for (int i = 1; i < BUFFER_SIZE; i++) {
                                     int x1 = (i - 1) * width / BUFFER_SIZE;
                                     int y1 = (height / 2) + (int)(audioBuffer[i - 1] * gain * (height / 2));
                                     int x2 = i * width / BUFFER_SIZE;
                                     int y2 = (height / 2) + (int)(audioBuffer[i] * gain * (height / 2));

                                     // Clamp y1 and y2 to window height
                                     if (y1 < 0) y1 = 0;
                                     if (y1 > height) y1 = height;
                                     if (y2 < 0) y2 = 0;
                                     if (y2 > height) y2 = height;

                                     SDL_RenderDrawLine(renderer, x1, y1, x2, y2);
                                 }

                                 SDL_RenderPresent(renderer);
                                 //SDL_Delay(16);  // ~60 FPS
                             }

                             Pa_StopStream(stream);
                             Pa_CloseStream(stream);
                             Pa_Terminate();
                             SDL_DestroyRenderer(renderer);
                             SDL_DestroyWindow(window);
                             SDL_Quit();

                             return 0;
                         }
