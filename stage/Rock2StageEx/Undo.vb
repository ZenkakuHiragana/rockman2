
Public Delegate Sub WritingFunction(ByRef writeTo As Object, ByRef data As Object)

Public Class Undo
    Private _writeTo As Object
    Private _data As Object
    Private _func As WritingFunction

    Public Sub New(ByRef target As Object, ByRef data As Object, ByRef func As WritingFunction)
        _writeTo = target
        _data = data
        _func = func
    End Sub

    Public Sub DoThis() '設定値に従いUndoを実行する
        If _func Is Nothing Then Return
        _func(Me.WriteTo, Me.Data)
    End Sub

    Property WriteTo As Object
        Get
            Return _writeTo
        End Get
        Set(value As Object)
            _writeTo = value
        End Set
    End Property

    Property Data As Object '書き込み対象のオブジェクト
        Get
            Return _data
        End Get
        Set(value As Object)
            _data = value
        End Set
    End Property

    Property Func As WritingFunction '書き込み関数
        Get
            Return _func
        End Get
        Set(value As WritingFunction)
            _func = value
        End Set
    End Property
End Class

Partial Public Class Form1
    'Undoを実際に行い、データの書き込みと再表示をする もっとマシな実装はなかったんですかね
    Private Sub DefaultUndoMethod(ByRef writeTo As Object, ByRef data As Object)
        writeTo = data
    End Sub
    'マップの変更用のUndo(UInteger, Byte)
    Private Sub UndoMap(ByRef roomptr As Object, ByRef data As Object)
        room(CUInt(roomptr)) = CByte(data)
    End Sub
    'マップの貼り付け処理のUndo(UInteger, ArrayList)
    Private Sub UndoPasteMap(ByRef numroom As Object, ByRef data As Object)
        Dim undolist() As ArrayList = DirectCast(data, ArrayList())
        If undolist Is Nothing Then Return

        Dim i As UInteger = 0 'ループ用一時変数
        For Each o As Byte In undolist(0)
            If room.Length > numroom * &H40 + i Then
                room(numroom * &H40 + i) = o
                i += 1
            End If
        Next

        EnemiesArray(numroom).Clear() '敵位置情報のペースト
        For Each o As EnemyStructure In undolist(1)
            EnemiesArray(numroom).Add(o)
        Next

        ItemsArray(numroom).Clear() 'アイテム情報のペースト
        For Each o As EnemyStructure In undolist(2)
            ItemsArray(numroom).Add(o)
        Next
    End Sub
    '32x32タイル変更用のUndo(Point, Point)
    Private Sub Undo32(ByRef writeTo As Object, ByRef data As Object)
        Dim ptr As Point = DirectCast(writeTo, Point)
        Dim value As Point = DirectCast(data, Point)
        attr(ptr.X) = value.X
        chip(ptr.Y) = value.Y
    End Sub
    '32x32タイルの貼り付け処理のUndo(UInteger, ArrayList)
    Private Sub UndoPaste32(ByRef writeTo As Object, ByRef data As Object)
        Dim undolist As ArrayList = DirectCast(data, ArrayList)
        If undolist Is Nothing Then Return

        For i As UInteger = 0 To 3
            chip(CUInt(writeTo) * 4 + i) = undolist(i)
        Next

        attr(writeTo) = undolist(4)
        flag(writeTo * 2) = undolist(5)
        flag(writeTo * 2 + 1) = undolist(6)
    End Sub
    '16x16タイル変更用のUndo(Uinteger, Byte)
    Private Sub Undo16(ByRef writeTo As Object, ByRef data As Object)
        tile(CUInt(writeTo)) = CByte(data)
    End Sub
    '16x16タイルの貼り付け処理のUndo(UInteger, ArrayList)
    Private Sub UndoPaste16(ByRef writeTo As Object, ByRef data As Object)
        Dim undolist As ArrayList = DirectCast(data, ArrayList)
        If undolist Is Nothing Then Return

        For i As UInteger = 0 To 3
            tile(writeTo + i) = undolist(i)
        Next
    End Sub
    '地形判定情報のUndo(UInteger, Byte)
    Private Sub UndoFlags(ByRef writeTo As Object, ByRef data As Object)
        flag(CUInt(writeTo)) = CByte(data)
    End Sub
    '敵の新規作成のUndo(UInteger, EnemyStructure)
    Private Sub UndoCreateEnemy(ByRef writeTo As Object, ByRef data As Object)
        Dim del As EnemyStructure = TryCast(data, EnemyStructure)
        If del Is Nothing Then Return
        EnemiesArray(CUInt(writeTo)).Remove(del)
        ClearObjectSelection()
    End Sub
    'アイテムの新規作成のUndo(UInteger, EnemyStructure)
    Private Sub UndoCreateItem(ByRef writeTo As Object, ByRef data As Object)
        Dim del As EnemyStructure = TryCast(data, EnemyStructure)
        If del Is Nothing Then Return
        ItemsArray(CUInt(writeTo)).Remove(del)
        ClearObjectSelection()
    End Sub
    '敵の削除のUndo(UInteger, EnemyStructure)
    Private Sub UndoDeleteEnemy(ByRef writeTo As Object, ByRef data As Object)
        Dim create As EnemyStructure = TryCast(data, EnemyStructure)
        If create Is Nothing Then Return
        EnemiesArray(CUInt(writeTo)).Add(create)
    End Sub
    'アイテムの削除のUndo(UInteger, EnemyStructure)
    Private Sub UndoDeleteItem(ByRef writeTo As Object, ByRef data As Object)
        Dim create As EnemyStructure = TryCast(data, EnemyStructure)
        If create Is Nothing Then Return
        ItemsArray(CUInt(writeTo)).Add(create)
    End Sub

    'Undoオブジェクトを追加する
    Private Sub AddUndo(ByRef target As Object, ByVal data As Object, Optional ByRef func As WritingFunction = Nothing)
        Dim _func As WritingFunction = func
        If _func Is Nothing Then _func = New WritingFunction(AddressOf DefaultUndoMethod)
        UndoBuffer.Add(New Undo(target, data, func))

        UndoToolStripMenuItem.Enabled = True
    End Sub

    'Undo情報を消去する
    Private Sub ClearUndo()
        UndoBuffer.Clear()
        UndoToolStripMenuItem.Enabled = False
    End Sub
End Class
