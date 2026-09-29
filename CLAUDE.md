# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a static landing page for Quixi.AI, an open-source AI research platform. The entire website is contained in a single `index.html` file with inline CSS and JavaScript.

## Technology Stack

- **HTML5** with semantic markup
- **CSS3** with custom properties (CSS variables) for theming
- **Vanilla JavaScript** for interactive features (mobile menu, smooth scrolling)
- **No build tools or dependencies** - pure static HTML

## Commands

Since this is a static HTML site, there are no build commands. To work with this project:

- **View the site**: Open `index.html` directly in a web browser
- **Deploy**: Copy `index.html` to any web server or static hosting service
- **Development**: Edit `index.html` directly and refresh the browser

## Architecture

`index.html` is a single-page showcase of Eric Hartford's work, framed as one stack:

1. **Header** - Fixed nav with section links, social icons (hidden below 1100px), mobile menu
2. **Hero** - Interactive WIPE-style spring-lattice `<canvas>` (cursor warps it, clicks detonate)
3. **The Stack** - Layer cards: Homelab (L1) → QuixiCore (L2) → SlimServe (L3) → Hexis (L4), plus With, WIPE, Book
4. **Project features** - `#slimserve` (benchmark bars), `#quixicore`, `#hexis`, `#with`
5. **WIPE** (`#wipe`) - Gameplay video `media/wipe-gameplay.mp4` (960px re-encode) with poster `media/wipe-poster.jpg`; autoplays muted only while on screen
6. **Homelab** (`#lab`) - Rack illustration linked to a hardware manifest via `data-k` hover
7. **Affine** - Bittensor subnet callout
8. **Book** (`#book`) - *Local and On-Prem AI*, CSS cover and chapter list
9. **Work with me** (`#work`) - Server rental, model training, data curation, consultation (mailto links with subjects)
10. **About** (`#about`) and **Footer**

`hexis.html`, `hexis-*.html`, and `hexis.sh` (served at quixi.ai/hexis.sh) are live.

## Design System

Colors are CSS custom properties in `:root`: primary `#8B5CF6`, plus WIPE neon accents `--lime`, `--magenta`, `--cyan`, `--amber` on a near-black background. Breakpoints: 980px (grids collapse) and 768px (mobile nav). Grid children get `min-width: 0` so wide code/terminal lines don't force horizontal page scroll.

## Development Notes

- All styles are in a single `<style>` tag - consider maintaining this pattern for simplicity
- The site is fully self-contained with no external dependencies
- Mobile-first responsive design with media queries at 768px breakpoint
- Form submissions currently have no backend - they use `#` as action