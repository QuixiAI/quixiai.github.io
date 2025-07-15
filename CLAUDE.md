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

The landing page is structured as a single-page application with the following sections:

1. **Header** - Sticky navigation with logo and menu
2. **Hero Section** - Introduction to Eric Hartford and the platform
3. **Features Section** - Four main research areas displayed in a grid
4. **Testimonials** - User feedback carousel
5. **Pricing** - Three-tier pricing structure
6. **CTA Section** - Statistics and call-to-action buttons
7. **Footer** - Links, newsletter signup, and social media

## Design System

The site uses CSS custom properties defined in `:root` for consistent theming:
- Primary color: `#8B5CF6` (purple)
- Responsive breakpoint: 768px for mobile/desktop
- Dark background with light text for modern aesthetic

## Key Implementation Details

- **Mobile Navigation**: JavaScript toggle for hamburger menu at `/Volumes/SB-XTM5/git/quixi-landing/index.html:506`
- **Smooth Scrolling**: Implemented for anchor links at `/Volumes/SB-XTM5/git/quixi-landing/index.html:518`
- **Responsive Grid**: Features section uses CSS Grid with auto-fit
- **Accessibility**: ARIA labels and semantic HTML throughout

## Development Notes

- All styles are in a single `<style>` tag - consider maintaining this pattern for simplicity
- The site is fully self-contained with no external dependencies
- Mobile-first responsive design with media queries at 768px breakpoint
- Form submissions currently have no backend - they use `#` as action