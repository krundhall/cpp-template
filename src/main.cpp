#define RAYLIB
#ifdef RAYLIB
#include "raylib.h"
#endif

#include <iostream>
#include <string>

int main(int argc, char **argv)
{
    std::cout << "Hello from cpp-template!\n";

#ifdef RAYLIB
    InitWindow(800, 450, "Template App");
    SetTargetFPS(60);

    while (!WindowShouldClose())
    {
        BeginDrawing();
        ClearBackground(RAYWHITE);
        DrawText("Ready for flashcards!", 180, 200, 30, DARKGRAY);
        EndDrawing();
    }
    CloseWindow();
#else
    std::cout << "(Console mode – add raylib by uncommenting Fetch + header)\n";
#endif

    return 0;
}
