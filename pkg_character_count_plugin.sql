CREATE PACKAGE ace_char_counter AS
-- =============================================================================
-- Package: ACE_CHAR_COUNTER
-- Plugin Type: Item Plugin
-- Internal Name: COM.ORACLE.ACE.CHARACTER.COUNTER
-- Description: Adds a live character counter below any APEX Textarea or
--              Text Field, showing remaining/used characters with color alerts.
-- Author: [Your Name] - Oracle ACE Apprentice
-- Version: 1.0.0
-- =============================================================================

  FUNCTION render (
    p_item                IN apex_plugin.t_item,
    p_plugin              IN apex_plugin.t_plugin,
    p_param               IN apex_plugin.t_item_render_param,
    p_result              IN OUT NOCOPY apex_plugin.t_item_render_result
  ) RETURN apex_plugin.t_item_render_result;

  FUNCTION ajax (
    p_item   IN apex_plugin.t_item,
    p_plugin IN apex_plugin.t_plugin
  ) RETURN apex_plugin.t_item_ajax_result;

END ace_char_counter;
/

CREATE PACKAGE BODY ace_char_counter AS

  -- ---------------------------------------------------------------------------
  -- FUNCTION: render
  -- Renders a character counter below a native APEX textarea/text item.
  -- ---------------------------------------------------------------------------
  FUNCTION render (
    p_item                IN apex_plugin.t_item,
    p_plugin              IN apex_plugin.t_plugin,
    p_param               IN apex_plugin.t_item_render_param,
    p_result              IN OUT NOCOPY apex_plugin.t_item_render_result
  ) RETURN apex_plugin.t_item_render_result AS

    l_result       apex_plugin.t_item_render_result;
    l_max_length   NUMBER         := NVL(TO_NUMBER(p_item.attribute_01), 500);
    l_mode         VARCHAR2(10)   := NVL(p_item.attribute_02, 'remaining');  -- remaining | used
    l_warn_pct     NUMBER         := NVL(TO_NUMBER(p_item.attribute_03), 20);
    l_item_name    VARCHAR2(255)  := p_item.name;
    l_item_value   VARCHAR2(4000) := NVL(p_item.value, '');
    l_current_len  NUMBER         := LENGTH(l_item_value);
    l_counter_id   VARCHAR2(255)  := l_item_name || '_ACE_COUNTER';

  BEGIN

    -- Render the native textarea/text input
    apex_plugin_util.print_standard_field (
      p_item                   => p_item,
      p_plugin                 => p_plugin,
      p_param                  => p_param,
      p_max_length             => l_max_length,
      p_result                 => l_result
    );

    -- Render counter div below the field
    htp.p(
      '<div id="' || apex_escape.html_attribute(l_counter_id) || '" ' ||
           'class="ace-char-counter" ' ||
           'aria-live="polite">' ||
      '</div>'
    );

    -- Inject CSS (once per page)
    apex_css.add(
      p_css =>
        '.ace-char-counter { ' ||
          'font-size: 12px; margin-top: 4px; text-align: right; ' ||
          'font-family: inherit; transition: color 0.3s; ' ||
        '}' ||
        '.ace-char-counter.ace-ok      { color: #5a6268; }' ||
        '.ace-char-counter.ace-warning { color: #e67e22; font-weight: 600; }' ||
        '.ace-char-counter.ace-danger  { color: #e74c3c; font-weight: 700; }',
      p_key => 'ace-char-counter-css'
    );

    -- Inject JavaScript to wire up live counting
    apex_javascript.add_onload_code(
      p_code =>
        '(function() {' ||
        '  var itemEl    = document.getElementById(' || apex_javascript.add_value(l_item_name) || ');' ||
        '  var counterEl = document.getElementById(' || apex_javascript.add_value(l_counter_id) || ');' ||
        '  var maxLen    = ' || l_max_length || ';' ||
        '  var mode      = ' || apex_javascript.add_value(l_mode) || ';' ||
        '  var warnPct   = ' || l_warn_pct || ';' ||
        '  if (!itemEl || !counterEl) return;' ||

        '  function updateCounter() {' ||
        '    var len     = itemEl.value.length;' ||
        '    var remain  = maxLen - len;' ||
        '    var pctUsed = (len / maxLen) * 100;' ||
        '    var label   = (mode === "used")' ||
        '                    ? len + " / " + maxLen + " characters used"' ||
        '                    : remain + " characters remaining";' ||
        '    counterEl.textContent = label;' ||
        '    counterEl.className = "ace-char-counter";' ||
        '    if (pctUsed >= 100) {' ||
        '      counterEl.classList.add("ace-danger");' ||
        '      itemEl.setAttribute("aria-invalid", "true");' ||
        '    } else if (pctUsed >= (100 - warnPct)) {' ||
        '      counterEl.classList.add("ace-warning");' ||
        '      itemEl.removeAttribute("aria-invalid");' ||
        '    } else {' ||
        '      counterEl.classList.add("ace-ok");' ||
        '      itemEl.removeAttribute("aria-invalid");' ||
        '    }' ||
        '  }' ||

        '  itemEl.addEventListener("input",  updateCounter);' ||
        '  itemEl.addEventListener("change", updateCounter);' ||
        '  updateCounter();' || -- Initialize on page load
        '})();'
    );

    RETURN l_result;

  EXCEPTION
    WHEN OTHERS THEN
      apex_debug.error('ACE Character Counter Plugin Error: %s', SQLERRM);
      RAISE;
  END render;

  -- ---------------------------------------------------------------------------
  -- FUNCTION: ajax (placeholder - not used in this plugin)
  -- ---------------------------------------------------------------------------
  FUNCTION ajax (
    p_item   IN apex_plugin.t_item,
    p_plugin IN apex_plugin.t_plugin
  ) RETURN apex_plugin.t_item_ajax_result AS
    l_result apex_plugin.t_item_ajax_result;
  BEGIN
    RETURN l_result;
  END ajax;

END ace_char_counter;
/