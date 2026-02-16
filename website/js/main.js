/* ============================================
   Securing the Agentic Frontier - Main JS
   ============================================ */

document.addEventListener('DOMContentLoaded', () => {
  initNavigation();
  initScrollSpy();
  initMaestroLayers();
  initAccordions();
  initTabs();
  initAnimations();
  initMobileMenu();
  initCounters();
  initMermaid();
});

/* --- Navigation scroll effect --- */
function initNavigation() {
  const navbar = document.querySelector('.navbar');
  if (!navbar) return;
  window.addEventListener('scroll', () => {
    navbar.classList.toggle('scrolled', window.scrollY > 20);
  }, { passive: true });
}

/* --- Scroll Spy --- */
function initScrollSpy() {
  const sections = document.querySelectorAll('.section[id], .hero[id]');
  const navLinks = document.querySelectorAll('.nav-links a');
  if (!sections.length || !navLinks.length) return;

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        const id = entry.target.id;
        navLinks.forEach(link => {
          link.classList.toggle('active', link.getAttribute('href') === `#${id}`);
        });
      }
    });
  }, { rootMargin: '-30% 0px -70% 0px' });

  sections.forEach(s => observer.observe(s));
}

/* --- MAESTRO Layers accordion --- */
function initMaestroLayers() {
  document.querySelectorAll('.maestro-layer .layer-header').forEach(header => {
    header.addEventListener('click', () => {
      const layer = header.closest('.maestro-layer');
      const wasActive = layer.classList.contains('active');
      // Close all
      document.querySelectorAll('.maestro-layer').forEach(l => l.classList.remove('active'));
      // Toggle clicked
      if (!wasActive) layer.classList.add('active');
    });
  });
}

/* --- Generic Accordions --- */
function initAccordions() {
  document.querySelectorAll('.accordion-header').forEach(header => {
    header.addEventListener('click', () => {
      const item = header.closest('.accordion-item');
      const wasOpen = item.classList.contains('open');
      // Close siblings
      item.parentElement.querySelectorAll('.accordion-item').forEach(i => i.classList.remove('open'));
      if (!wasOpen) item.classList.add('open');
    });
  });
}

/* --- Tabs --- */
function initTabs() {
  document.querySelectorAll('.tabs').forEach(tabGroup => {
    const buttons = tabGroup.querySelectorAll('.tab-btn');
    const container = tabGroup.closest('.tab-container') || tabGroup.parentElement;
    const panels = container.querySelectorAll('.tab-panel');

    buttons.forEach(btn => {
      btn.addEventListener('click', () => {
        const target = btn.dataset.tab;
        buttons.forEach(b => b.classList.remove('active'));
        panels.forEach(p => p.classList.remove('active'));
        btn.classList.add('active');
        const panel = container.querySelector(`#${target}`);
        if (panel) panel.classList.add('active');
      });
    });
  });
}

/* --- Scroll Animations --- */
function initAnimations() {
  const elements = document.querySelectorAll('.fade-in');
  if (!elements.length) return;

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
        observer.unobserve(entry.target);
      }
    });
  }, { threshold: 0.1 });

  elements.forEach(el => observer.observe(el));
}

/* --- Mobile Menu --- */
function initMobileMenu() {
  const toggle = document.querySelector('.mobile-toggle');
  const links = document.querySelector('.nav-links');
  if (!toggle || !links) return;

  toggle.addEventListener('click', () => {
    links.classList.toggle('open');
    toggle.textContent = links.classList.contains('open') ? '\u2715' : '\u2630';
  });

  // Close on link click
  links.querySelectorAll('a').forEach(a => {
    a.addEventListener('click', () => {
      links.classList.remove('open');
      toggle.textContent = '\u2630';
    });
  });
}

/* --- Animated Counters --- */
function initCounters() {
  const counters = document.querySelectorAll('[data-count]');
  if (!counters.length) return;

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        animateCounter(entry.target);
        observer.unobserve(entry.target);
      }
    });
  }, { threshold: 0.5 });

  counters.forEach(c => observer.observe(c));
}

function animateCounter(el) {
  const target = parseInt(el.dataset.count, 10);
  const suffix = el.dataset.suffix || '';
  const prefix = el.dataset.prefix || '';
  const duration = 1500;
  const start = performance.now();

  function update(now) {
    const progress = Math.min((now - start) / duration, 1);
    const eased = 1 - Math.pow(1 - progress, 3); // ease-out cubic
    const current = Math.round(eased * target);
    el.textContent = prefix + current + suffix;
    if (progress < 1) requestAnimationFrame(update);
  }

  requestAnimationFrame(update);
}

/* --- Mermaid Diagrams --- */
function initMermaid() {
  if (typeof mermaid !== 'undefined') {
    mermaid.initialize({
      startOnLoad: true,
      theme: 'dark',
      themeVariables: {
        darkMode: true,
        background: '#1a1f35',
        primaryColor: '#7c3aed',
        primaryTextColor: '#e2e8f0',
        primaryBorderColor: '#334155',
        lineColor: '#64748b',
        secondaryColor: '#0d1117',
        tertiaryColor: '#111827',
        fontFamily: 'Inter, sans-serif'
      },
      flowchart: { curve: 'basis' },
      sequence: { mirrorActors: false }
    });
  }
}
