---
title: e大纲
date: 2023-05-15
categories: [编程]
tags: [VBA]
---

## e大纲

<!--more-->

```VBA
Sub 大纲一级(control As IRibbonControl) '大纲调整-一级
    With Selection
        .Paragraphs.OutlineLevel = wdOutlineLevel1
    End With
End Sub
Sub 大纲二级(control As IRibbonControl) '大纲调整-二级
    With Selection
        .Paragraphs.OutlineLevel = wdOutlineLevel2
    End With
End Sub
Sub 大纲三级(control As IRibbonControl) '大纲调整-三级
    With Selection
        .Paragraphs.OutlineLevel = wdOutlineLevel3
    End With
End Sub
Sub 大纲四级(control As IRibbonControl) '大纲调整-四级
    With Selection
        .Paragraphs.OutlineLevel = wdOutlineLevel4
    End With
End Sub
Sub 大纲五级(control As IRibbonControl) '大纲调整-五级
    With Selection
        .Paragraphs.OutlineLevel = wdOutlineLevel5
    End With
End Sub
Sub 大纲正文(control As IRibbonControl) '大纲调整-正文
    With Selection
        .Paragraphs.OutlineLevel = wdOutlineLevelBodyText
    End With
End Sub
```

