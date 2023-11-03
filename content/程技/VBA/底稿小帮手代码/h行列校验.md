---
title: h行列校验
date: 2023-05-15
type: posts
categories: [程技]
tags: [VBA]
---

## h行列校验


<!--more-->

```vb
Sub 选行校验(control As IRibbonControl) '行列校验-选行校验
    i = 0
    x = 0
    n = 0
    If Selection.Type = wdSelectionColumn Then
        For Each Acell In Selection.Cells '求所选列合计数
            If Acell.ColumnIndex > n Then
                n = Acell.ColumnIndex
            End If
            Set CR1 = ActiveDocument.Range(Acell.Range.Start, Acell.Range.End - 1)
            If IsNumeric(CR1.Text) Then
                i = CR1.Text + i
            End If
        Next
        For Each Acell In Selection.Cells '求所选列最后一行合计数
            Set CR2 = ActiveDocument.Range(Acell.Range.Start, Acell.Range.End - 1)
            If Acell.ColumnIndex = n Then
                If IsNumeric(CR2.Text) Then
                    x = CR2.Text + x
                End If
            End If
        Next
        P = i - x
        q = P - x
        y = "列校验:" & Format(P, "Standard") & "-" & Format(x, "Standard") & "=" & Format(q, "Standard")
    Else
        y = "只支持选中表格范围!"
    End If
    Application.StatusBar = y
End Sub
Sub 选列校验(control As IRibbonControl) '行列校验-选列校验
    i = 0
    x = 0
    n = 0
    If Selection.Type = wdSelectionColumn Then
        For Each Acell In Selection.Cells '求所选列合计数
            If Acell.RowIndex > n Then
                n = Acell.RowIndex
            End If
            Set CR1 = ActiveDocument.Range(Acell.Range.Start, Acell.Range.End - 1)
            If IsNumeric(CR1.Text) Then
                i = CR1.Text + i
            End If
        Next
        For Each Acell In Selection.Cells '求所选列最后一行合计数
            Set CR2 = ActiveDocument.Range(Acell.Range.Start, Acell.Range.End - 1)
            If Acell.RowIndex = n Then
                If IsNumeric(CR2.Text) Then
                    x = CR2.Text + x
                End If
            End If
        Next
        P = i - x
        q = P - x
        y = "列校验:" & Format(P, "Standard") & "-" & Format(x, "Standard") & "=" & Format(q, "Standard")
    Else
        y = "只支持选中表格范围!"
    End If
    Application.StatusBar = y
End Sub
Sub 区域求和(control As IRibbonControl) '行列校验-区域求和
    i = 0
    If Selection.Type = 5 Then
        For Each Acell In Selection.Cells
            Set CR = ActiveDocument.Range(Acell.Range.Start, Acell.Range.End - 1)
            If IsNumeric(CR.Text) Then
                i = CR.Text + i
            End If
        Next
        i = "合计:" & Format(i, "#,##0.00;-#,##0.00; ")
    ElseIf Selection.Type = 4 Then
        For Each Acell In Selection.Cells
            Set CR = ActiveDocument.Range(Acell.Range.Start, Acell.Range.End - 1)
            If IsNumeric(CR.Text) Then
                i = CR.Text + i
            End If
        Next
        i = "合计:" & Format(i, "#,##0.00;-#,##0.00; ")
    Else
        i = "只支持表格内行或列求和!"
    End If
    Application.StatusBar = i
End Sub
```

