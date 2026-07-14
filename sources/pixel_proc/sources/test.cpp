#include <stdint.h>
#include <stdio.h>
#include "hls/hls_alloc.h"

#ifndef MAX_PIXELS
#define MAX_PIXELS 2073600
#endif

#ifndef INPUT_BYTES_PER_PIXEL
#define INPUT_BYTES_PER_PIXEL 96
#endif

#define ENTRIES_PER_PIXEL 24
#define BYTES_PER_ENTRY 4
#define MATCHING_THRESHOLD 45
#define MATCHING_NUMBER 2
#define COLOR_BACKGROUND 0
#define COLOR_FOREGROUND 255

static uint8_t rgbx_r(uint32_t v) { return (uint8_t)(v & 0xffu); }
static uint8_t rgbx_g(uint32_t v) { return (uint8_t)((v >> 8) & 0xffu); }
static uint8_t rgbx_b(uint32_t v) { return (uint8_t)((v >> 16) & 0xffu); }

static uint8_t abs_diff(uint8_t a, uint8_t b)
{
  return (a > b) ? (uint8_t)(a - b) : (uint8_t)(b - a);
}

static uint8_t classify_pixel(const uint32_t *input, uint32_t pixel_index)
{
  uint32_t base = pixel_index * ENTRIES_PER_PIXEL;
  uint32_t cur = input[base];
  uint8_t cr = rgbx_r(cur);
  uint8_t cg = rgbx_g(cur);
  uint8_t cb = rgbx_b(cur);
  uint8_t matches = 0;

  #pragma HLS loop pipeline
  for (uint32_t i = 1; i < ENTRIES_PER_PIXEL; ++i) {
    uint32_t hist = input[base + i];
    uint16_t sad = (uint16_t)abs_diff(cr, rgbx_r(hist))
                 + (uint16_t)abs_diff(cg, rgbx_g(hist))
                 + (uint16_t)abs_diff(cb, rgbx_b(hist));
    if (sad <= MATCHING_THRESHOLD)
      ++matches;
  }

  return (matches <= MATCHING_NUMBER) ? COLOR_FOREGROUND : COLOR_BACKGROUND;
}

void pixel_proc(uint32_t input[MAX_PIXELS * ENTRIES_PER_PIXEL],
                uint8_t output[MAX_PIXELS],
                uint32_t pixel_count)
{
  #pragma HLS function top
  #pragma HLS interface default type(axi_target)
  #pragma HLS interface argument(input) type(axi_initiator) num_elements(MAX_PIXELS * ENTRIES_PER_PIXEL) max_burst_len(256)
  #pragma HLS interface argument(output) type(axi_initiator) num_elements(MAX_PIXELS) max_burst_len(256)

  uint32_t bounded_count = (pixel_count > MAX_PIXELS) ? (uint32_t)MAX_PIXELS : pixel_count;

  for (uint32_t i = 0; i < bounded_count; ++i)
    output[i] = classify_pixel(input, i);
}

#ifndef __SYNTHESIS__
static uint32_t make_rgbx(uint8_t r, uint8_t g, uint8_t b)
{
  return ((uint32_t)b << 16) | ((uint32_t)g << 8) | (uint32_t)r;
}

int main()
{
  const uint32_t pixel_count = 4;
  uint32_t *input = (uint32_t *)hls_malloc(
      sizeof(uint32_t) * pixel_count * ENTRIES_PER_PIXEL, HLS_ALLOC_NONCACHED);
  uint8_t *output = (uint8_t *)hls_malloc(
      sizeof(uint8_t) * pixel_count, HLS_ALLOC_NONCACHED);

  if (!input || !output) {
    printf("failed: allocation\n");
    return 1;
  }

  for (uint32_t p = 0; p < pixel_count; ++p) {
    uint32_t base = p * ENTRIES_PER_PIXEL;
    input[base] = make_rgbx(20, 30, 40);
    for (uint32_t i = 1; i < ENTRIES_PER_PIXEL; ++i)
      input[base + i] = make_rgbx(20, 30, 40);
  }

  for (uint32_t i = 1; i < ENTRIES_PER_PIXEL; ++i)
    input[1 * ENTRIES_PER_PIXEL + i] = make_rgbx(200, 210, 220);

  pixel_proc(input, output, pixel_count);

  const uint8_t expected[4] = {
    COLOR_BACKGROUND,
    COLOR_FOREGROUND,
    COLOR_BACKGROUND,
    COLOR_BACKGROUND
  };

  for (uint32_t i = 0; i < pixel_count; ++i) {
    if (output[i] != expected[i]) {
      printf("failed: pixel %u expected %u actual %u\n",
             i, expected[i], output[i]);
      return 1;
    }
  }

  hls_free(output);
  hls_free(input);
  printf("Passed!\n");
  return 0;
}
#endif
