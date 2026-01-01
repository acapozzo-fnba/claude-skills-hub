# Typst PDF Generator Verification Checklist

Use this checklist to verify the skill is complete and functional.

## File Structure

- [ ] `skills/typst-pdf-generator/SKILL.md` exists
- [ ] `skills/typst-pdf-generator/README.md` exists
- [ ] `skills/typst-pdf-generator/templates/minimal.typ` exists
- [ ] `skills/typst-pdf-generator/templates/technical.typ` exists
- [ ] `skills/typst-pdf-generator/templates/academic.typ` exists
- [ ] `skills/typst-pdf-generator/templates/report.typ` exists
- [ ] `skills/typst-pdf-generator/templates/presentation.typ` exists
- [ ] `skills/typst-pdf-generator/test-document.md` exists

## Template Validation

Run these commands to verify templates are valid Typst:

```bash
cd skills/typst-pdf-generator/templates

# Test each template with dummy content
for template in *.typ; do
  echo "Testing $template..."
  echo "Test content" | typst compile - test.pdf \
    --template "$template" \
    --input title="Test" \
    --input author="Test Author" || echo "FAILED: $template"
done
```

## Skill Documentation Completeness

- [ ] SKILL.md includes overview and purpose
- [ ] SKILL.md includes all 9 workflow steps
- [ ] SKILL.md includes error handling section
- [ ] SKILL.md includes template documentation
- [ ] SKILL.md includes examples
- [ ] SKILL.md includes progress feedback
- [ ] SKILL.md includes quick reference
- [ ] README.md explains usage clearly
- [ ] README.md includes installation instructions
- [ ] README.md documents all templates

## Functional Testing

Test the skill with various scenarios:

### Test 1: Simple Markdown
```
"Generate a PDF from skills/typst-pdf-generator/test-document.md"
```

Expected:
- Creates ~/Documents/typist/{timestamp}-test-document/
- Selects 'technical' template (has code blocks)
- Generates document.pdf
- Opens PDF

### Test 2: Custom Template Selection
Create markdown with frontmatter:
```yaml
---
template: academic
---
```

Expected:
- Uses academic template
- Creates title page
- Numbered sections

### Test 3: Image Handling
Create markdown with image reference, verify:
- Image copied to images/ folder
- PDF includes the image
- Missing images generate warnings but don't fail

### Test 4: Error Handling
Test with invalid markdown, verify:
- Clear error messages
- Preserves intermediate files for debugging
- build.log contains details

## Integration Testing

- [ ] Test with real-world markdown files
- [ ] Verify all templates produce valid PDFs
- [ ] Confirm custom templates work
- [ ] Check disk space warnings work
- [ ] Verify metadata.json is correct

## Documentation

- [ ] Design doc exists: `docs/plans/2025-10-24-typst-pdf-generator-design.md`
- [ ] All commits follow conventional commit format
- [ ] Git history is clean and logical

## Ready for Use

Once all checks pass:
1. Merge feature branch to main
2. Test skill from main session
3. Add to Claude Code skills documentation
