// --------------------------------------------------------------------------
// Object Pascal Wrapper for Shapefile C Library
// by Javier Santo Domingo (j-a-s-d@coderesearchlabs.com), 2006-2011, MIT
// --------------------------------------------------------------------------

program ShpDump;

{$APPTYPE CONSOLE}
{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

uses
  ShpFiles;

{$DEFINE USING_FACTORY}

  procedure ShowShapeFileInfo(const AFile: string);
{$IFDEF USING_FACTORY}
  begin
    with ShapeFile(AFile, [loCaptureDetailedFileInfo, loDBFAttributesGetNativeFieldType]) do
      if FileLoadResult = lrOk then
        WriteLn(FileInfo);
  end;
{$ELSE}
  var shpFile: TShapeFile;
  begin
    shpFile := TShapeFile.Create;
    try
      if shpFile.LoadFromFile(AFile, [loCaptureDetailedFileInfo, loDBFAttributesGetNativeFieldType]) then
        WriteLn(shpFile.FileInfo);
    finally
      shpFile.Free;
    end;
  end;
{$ENDIF}

  procedure ShowHelp;
  begin
    WriteLn('--------------------------------------------------------------------------');
    WriteLn('Object Pascal Wrapper for Shapefile C Library - ShpDump demo');
    WriteLn('by Javier Santo Domingo (j-a-s-d@coderesearchlabs.com), 2006-2011, MIT');
    WriteLn('--------------------------------------------------------------------------');
    WriteLn('usage:');
    WriteLn('  ShpDump <shpfile>');
    WriteLn;
    WriteLn('example:');
    WriteLn('  ShpDump test.shp');
  end;

begin
  if ParamCount = 0 then
    ShowHelp
  else
    ShowShapeFileInfo(ParamStr(1));
end.
