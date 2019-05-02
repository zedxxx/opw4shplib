// --------------------------------------------------------------------------
// Object Pascal Wrapper for Shapefile C Library
// by Javier Santo Domingo (j-a-s-d@coderesearchlabs.com), 2006-2011, MIT
// --------------------------------------------------------------------------

program ShpDumpDir;

{$APPTYPE CONSOLE}
{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

uses
  Classes,
  ShpFiles;

  procedure ShowDirectoryShapeFilesInfo(const ADirectory: string);
  var st: TStringList; {$IFDEF FPC}shpFile: TShapeFile;{$ELSE}i: integer;{$ENDIF}
  begin
    with ShapeFilesDirectory(ADirectory, [loCaptureDetailedFileInfo, loDBFAttributesGetNativeFieldType]) do
      if not HasErrorsLoading then begin
      {$IFDEF FPC}
        for shpFile in ShapeFiles do
          WriteLn(shpFile.FileInfo);
      {$ELSE}
        for i := 0 to ShapeFiles.Count - 1 do
          WriteLn(ShapeFiles[i].FileInfo);
      {$ENDIF}
      end else begin
        st := TStringList.Create;
        try
          RetrieveLoadingErrorsReport(st);
          WriteLn(st.Text);
        finally
          st.Free;
        end;
      end;
  end;

  procedure ShowHelp;
  begin
    WriteLn('--------------------------------------------------------------------------');
    WriteLn('Object Pascal Wrapper for Shapefile C Library - ShpDumpDir demo');
    WriteLn('by Javier Santo Domingo (j-a-s-d@coderesearchlabs.com), 2006-2011, MIT');
    WriteLn('--------------------------------------------------------------------------');
    WriteLn('usage:');
    WriteLn('  ShpDumpDir <directory>');
    WriteLn;
    WriteLn('example:');
    WriteLn('  ShpDumpDir .\');
  end;

begin
  if ParamCount = 0 then
    ShowHelp
  else
    ShowDirectoryShapeFilesInfo(ParamStr(1));
end.
