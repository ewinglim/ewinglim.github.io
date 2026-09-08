/* ==========================================================================
   Ewe Win Lim — portfolio behaviour
   Vanilla JS, no dependencies. Every feature degrades to working HTML
   if this file fails to load.
   ========================================================================== */
(() => {
  "use strict";

  const $  = (sel, root = document) => root.querySelector(sel);
  const $$ = (sel, root = document) => Array.from(root.querySelectorAll(sel));

  /* ---------- sticky header shadow ---------- */
  const header = $(".site-header");
  if (header) {
    const sentinel = document.createElement("div");
    sentinel.setAttribute("aria-hidden", "true");
    header.before(sentinel);
    new IntersectionObserver(
      ([entry]) => header.setAttribute("data-stuck", String(!entry.isIntersecting)),
      { rootMargin: "0px" }
    ).observe(sentinel);
  }

  /* ---------- mobile nav ---------- */
  const toggle = $(".nav-toggle");
  const nav = $("#primary-nav");
  if (toggle && nav) {
    const setOpen = (open) => {
      toggle.setAttribute("aria-expanded", String(open));
      nav.setAttribute("data-open", String(open));
    };
    toggle.addEventListener("click", () =>
      setOpen(toggle.getAttribute("aria-expanded") !== "true")
    );
    nav.addEventListener("click", (e) => {
      if (e.target.closest("a")) setOpen(false);
    });
    document.addEventListener("keydown", (e) => {
      if (e.key === "Escape") setOpen(false);
    });
    // reset when we cross back to desktop
    matchMedia("(min-width: 761px)").addEventListener("change", (e) => {
      if (e.matches) setOpen(false);
    });
  }

  /* ---------- work filters ---------- */
  const filterBar = $("[data-filters]");
  const cards = $$("[data-studio]");
  const countEl = $("[data-count]");

  if (filterBar && cards.length) {
    const announce = $("#filter-status");

    const apply = (key) => {
      let shown = 0;
      cards.forEach((card) => {
        const match = key === "all" || card.dataset.studio === key;
        card.hidden = !match;
        if (match) shown += 1;
      });
      if (countEl) countEl.textContent = `${shown} of ${cards.length} shown`;
      if (announce) announce.textContent = `${shown} project${shown === 1 ? "" : "s"} shown`;
    };

    filterBar.addEventListener("click", (e) => {
      const btn = e.target.closest("button[data-filter]");
      if (!btn) return;
      $$("button[data-filter]", filterBar).forEach((b) =>
        b.setAttribute("aria-pressed", String(b === btn))
      );
      apply(btn.dataset.filter);
    });

    apply("all");
  }

  /* ---------- reveal on scroll ---------- */
  const revealables = $$("[data-reveal]");
  if (revealables.length) {
    if (!matchMedia("(prefers-reduced-motion: reduce)").matches && "IntersectionObserver" in window) {
      const io = new IntersectionObserver(
        (entries, obs) => {
          entries.forEach((entry) => {
            if (!entry.isIntersecting) return;
            entry.target.classList.add("is-visible");
            obs.unobserve(entry.target);
          });
        },
        { rootMargin: "0px 0px -8% 0px", threshold: 0.05 }
      );
      revealables.forEach((el) => io.observe(el));

      // Anything already in (or near) the first viewport is revealed on the
      // next frame rather than waiting on the observer, so above-the-fold
      // content is never briefly blank.
      requestAnimationFrame(() => {
        revealables.forEach((el) => {
          if (el.getBoundingClientRect().top < window.innerHeight * 1.15) {
            el.classList.add("is-visible");
          }
        });
      });
    } else {
      revealables.forEach((el) => el.classList.add("is-visible"));
    }
  }

  /* ---------- case-study table of contents ---------- */
  const toc = $(".toc");
  if (toc) {
    const links = $$("a[href^='#']", toc);
    const targets = links
      .map((a) => document.getElementById(a.getAttribute("href").slice(1)))
      .filter(Boolean);

    if (targets.length && "IntersectionObserver" in window) {
      const io = new IntersectionObserver(
        (entries) => {
          entries.forEach((entry) => {
            if (!entry.isIntersecting) return;
            links.forEach((a) =>
              a.classList.toggle("is-active", a.getAttribute("href") === `#${entry.target.id}`)
            );
          });
        },
        { rootMargin: "-25% 0px -65% 0px", threshold: 0 }
      );
      targets.forEach((t) => io.observe(t));
    }
  }

  /* ---------- current year ---------- */
  $$("[data-year]").forEach((el) => {
    el.textContent = String(new Date().getFullYear());
  });
})();
