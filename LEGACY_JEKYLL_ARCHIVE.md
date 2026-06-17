# Legacy Jekyll Site Archive

The pre-Quarto Jekyll site is archived in git on the local branch:

```bash
archive-pre-quarto-jekyll
```

That branch points at commit `df6889f`, the committed site state before the
Quarto rebuild files were added. It preserves the old Jekyll / beautiful-jekyll
source, layouts, includes, posts, assets, and course/resource pages as they were
known to git.

To inspect it without disturbing this working tree:

```bash
git worktree add ../simondhalliday-jekyll-archive archive-pre-quarto-jekyll
```

To restore a single file from the archive branch:

```bash
git restore --source archive-pre-quarto-jekyll -- path/to/file
```

The branch does not capture untracked local files that were already present in
this working tree before the rebuild. Those files remain in the current working
tree unless they are explicitly removed later.
