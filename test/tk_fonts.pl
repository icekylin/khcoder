package FontTest;
use strict;
use Tk;
use Tk::Font;
use Tk::FontDialog;
use Jcode;
require Encode if $] > 5.008;

my $self;
$self->{mw} = MainWindow->new;
bless $self, 'FontTest';

$self->{mw}->fontCreate('TKFN',
	-family => 'HiraginoKaku',
	-size   => 10
);
$self->{mw}->optionAdd('*font', "TKFN");

$self->{mw}->Label(
	-text => $self->gui_jchar('日本語のラベル'),
	-font => "TKFN"
)->pack();
$self->{mw}->Button(
	-text => $self->gui_jchar('Font変更'),
	-font => "TKFN",
	-command => sub {$self->font_change},
)->pack;


MainLoop;

sub font_change{
	my $self = shift;
	my $font = $self->{mw}->FontDialog(
		-title            => $self->gui_jchar('フォントの選択'),
		-familylabel      => $self->gui_jchar('フォント：'),
		-sizelabel        => $self->gui_jchar('サイズ：'),
		-cancellabel      => $self->gui_jchar('キャンセル'),
		-nicefontsbutton  => 0,
		-fixedfontsbutton => 0,
		-fontsizes        => [8,9,10,11,12,13,14,15,16,17,18,19,20],
		-sampletext       => $self->gui_jchar('KH Coderは計量テキスト分析を実践するためのツールです。'),
		-initfont         => ,"TKFN"
	)->Show;
	return unless $font;

	$self->{mw}->fontDelete('TKFN');
	$self->{mw}->fontCreate('TKFN',
		-family => $font->configure(-family),
		-size   => $font->configure(-size),
	);
	$self->{mw}->optionAdd('*font', "TKFN");
	
	print $font->configure(-size)."\n";
}

sub gui_jchar{
	my $self = shift;
	my $str = shift;
	if ($] > 5.008){
		return Encode::decode('eucjp',$str);
	} else {
		return Jcode->new($str)->sjis;
	}
}
