package gui_window::cod_netg;
use base qw(gui_window);

use strict;


#-------------#
#   GUI����   #

sub _new{
	my $self = shift;
	my $mw = $::main_gui->mw;
	my $win = $self->{win_obj};
	$win->title($self->gui_jt('�����ǥ��󥰡������ͥåȥ�������ץ����'));

	my $lf = $win->LabFrame(
		-label => 'Codes',
		-labelside => 'acrosstop',
		-borderwidth => 2,
	)->pack(-fill => 'both', -expand => 0, -side => 'left',-anchor => 'w');

	#my $rf = $win->Frame()
	#	->pack(-fill => 'both', -expand => 1);

	my $lf2 = $win->LabFrame(
		-label => 'Options',
		-labelside => 'acrosstop',
		-borderwidth => 2,
	)->pack(-fill => 'x', -expand => 0, -anchor => 'n');

	# �롼�롦�ե�����
	my %pack0 = (
		-anchor => 'w',
		-padx => 2,
		#-pady => 2,
		-fill => 'x',
		-expand => 0,
	);
	$self->{codf_obj} = gui_widget::codf->open(
		parent  => $lf,
		pack    => \%pack0,
		command => sub{$self->read_cfile;},
	);
	
	# �����ǥ���ñ��
	my $f1 = $lf->Frame()->pack(
		-fill => 'x',
		-padx => 2,
		-pady => 4
	);
	$f1->Label(
		-text => $self->gui_jchar('�����ǥ���ñ�̡�'),
		-font => "TKFN",
	)->pack(-side => 'left');
	my %pack1 = (
		-anchor => 'w',
		-padx => 2,
		-pady => 2,
	);
	$self->{tani_obj} = gui_widget::tani->open(
		parent => $f1,
		pack   => \%pack1,
	);

	# ����������
	$lf->Label(
		-text => $self->gui_jchar('����������'),
		-font => "TKFN",
	)->pack(-anchor => 'nw', -padx => 2, -pady => 0);

	my $f2 = $lf->Frame()->pack(
		-fill   => 'both',
		-expand => 1,
		-padx   => 2,
		-pady   => 2
	);

	$f2->Label(
		-text => $self->gui_jchar('����','euc'),
		-font => "TKFN"
	)->pack(
		-anchor => 'w',
		-side   => 'left',
	);

	my $f2_1 = $f2->Frame(
		-borderwidth        => 2,
		-relief             => 'sunken',
	)->pack(
			-anchor => 'w',
			-side   => 'left',
			-pady   => 2,
			-padx   => 2,
			-fill   => 'both',
			-expand => 1
	);

	# ������������HList
	$self->{hlist} = $f2_1->Scrolled(
		'HList',
		-scrollbars         => 'osoe',
		#-relief             => 'sunken',
		-font               => 'TKFN',
		-selectmode         => 'none',
		-indicator => 0,
		-highlightthickness => 0,
		-columns            => 1,
		-borderwidth        => 0,
		-height             => 12,
	)->pack(
		-fill   => 'both',
		-expand => 1
	);

	my $f2_2 = $f2->Frame()->pack(
		-fill   => 'x',
		-expand => 0,
		-side   => 'left'
	);
	$f2_2->Button(
		-text => $self->gui_jchar('���٤�'),
		-width => 8,
		-font => "TKFN",
		-borderwidth => 1,
		-command => sub{$self->select_all;}
	)->pack(-pady => 3);
	$f2_2->Button(
		-text => $self->gui_jchar('���ꥢ'),
		-width => 8,
		-font => "TKFN",
		-borderwidth => 1,
		-command => sub{$self->select_none;}
	)->pack();

	$lf->Label(
		-text => $self->gui_jchar('�����������ɤ�3�İʾ����򤷤Ʋ�������','euc'),
		-font => "TKFN",
	)->pack(
		-anchor => 'w',
		-padx   => 4,
	);




	# �����ط��μ���
	$lf2->Label(
		-text => $self->gui_jchar('�����ط���edge�ˤμ���'),
		-font => "TKFN",
	)->pack(-anchor => 'w');

	my $f5 = $lf2->Frame()->pack(
		-fill => 'x',
		-pady => 1
	);

	$f5->Label(
		-text => '  ',
		-font => "TKFN",
	)->pack(-anchor => 'w', -side => 'left');

	unless ( defined( $self->{radio_type} ) ){
		$self->{radio_type} = 'words';
	}

	$f5->Radiobutton(
		-text             => $self->gui_jchar('�� �� ��'),
		-font             => "TKFN",
		-variable         => \$self->{radio_type},
		-value            => 'words',
		-command          => sub{ $self->refresh(3);},
	)->pack(-anchor => 'nw', -side => 'left');

	$f5->Label(
		-text => ' ',
		-font => "TKFN",
	)->pack(-anchor => 'nw', -side => 'left');

	$f5->Radiobutton(
		-text             => $self->gui_jchar('�� �� �����ѿ������Ф�'),
		-font             => "TKFN",
		-variable         => \$self->{radio_type},
		-value            => 'twomode',
		-command          => sub{ $self->refresh(3);},
	)->pack(-anchor => 'nw');

	my $f6 = $lf2->Frame()->pack(
		-fill => 'x',
		-pady => 1
	);

	$f6->Label(
		-text => '  ',
		-font => "TKFN",
	)->pack(-anchor => 'w', -side => 'left');

	$self->{var_lab} = $f6->Label(
		-text => $self->gui_jchar('�����ѿ������Ф���'),
		-font => "TKFN",
	)->pack(-anchor => 'w', -side => 'left');

	$self->{var_obj} = gui_widget::select_a_var->open(
		parent        => $f6,
		tani          => $self->tani,
		show_headings => 1,
	);


	# edge����
	$lf2->Label(
		-text => $self->gui_jchar('���褹�붦���ط���edge�ˤιʤ����'),
		-font => "TKFN",
	)->pack(-anchor => 'w');

	my $f4 = $lf2->Frame()->pack(
		-fill => 'x',
		-pady => 2
	);

	$f4->Label(
		-text => '  ',
		-font => "TKFN",
	)->pack(-anchor => 'w', -side => 'left');

	$self->{radio} = 'n';
	$f4->Radiobutton(
		-text             => $self->gui_jchar('�������'),
		-font             => "TKFN",
		-variable         => \$self->{radio},
		-value            => 'n',
		-command          => sub{ $self->refresh;},
	)->pack(-anchor => 'w', -side => 'left');

	$self->{entry_edges_number} = $f4->Entry(
		-font       => "TKFN",
		-width      => 3,
		-background => 'white',
	)->pack(-side => 'left', -padx => 2);
	$self->{entry_edges_number}->insert(0,'60');
	$self->{entry_edges_number}->bind("<Key-Return>",sub{$self->_calc;});
	$self->config_entry_focusin($self->{entry_edges_number});

	$f4->Radiobutton(
		-text             => $self->gui_jchar('Jaccard������'),
		-font             => "TKFN",
		-variable         => \$self->{radio},
		-value            => 'j',
		-command          => sub{ $self->refresh;},
	)->pack(-anchor => 'w', -side => 'left');

	$self->{entry_edges_jac} = $f4->Entry(
		-font       => "TKFN",
		-width      => 4,
		-background => 'white',
	)->pack(-side => 'left', -padx => 2);
	$self->{entry_edges_jac}->insert(0,'0.2');
	$self->{entry_edges_jac}->bind("<Key-Return>",sub{$self->_calc;});
	$self->config_entry_focusin($self->{entry_edges_jac});

	$f4->Label(
		-text => $self->gui_jchar('�ʾ�'),
		-font => "TKFN",
	)->pack(-anchor => 'w', -side => 'left');

	# Edge��������Node���礭��
	$lf2->Checkbutton(
			-text     => $self->gui_jchar('���������ط��ۤ�������������','euc'),
			-variable => \$self->{check_use_weight_as_width},
			-anchor => 'w',
	)->pack(-anchor => 'w');

	$self->{wc_use_freq_as_size} = $lf2->Checkbutton(
			-text     => $self->gui_jchar('�и�����¿�������ɤۤ��礭���ߤ�����','euc'),
			-variable => \$self->{check_use_freq_as_size},
			-anchor   => 'w',
			-command  => sub{
				$self->{check_smaller_nodes} = 0;
				$self->refresh(3);
			},
	)->pack(-anchor => 'w');

	my $fontsize_frame = $lf2->Frame()->pack(
		-fill => 'x',
		-pady => 0,
		-padx => 0,
	);

	$fontsize_frame->Label(
		-text => '  ',
		-font => "TKFN",
	)->pack(-anchor => 'w', -side => 'left');
	
	$self->{wc_use_freq_as_fsize} = $fontsize_frame->Checkbutton(
			-text     => $self->gui_jchar('�ե���Ȥ��礭�� ��EMF��EPS�Ǥν��ϡ���������','euc'),
			-variable => \$self->{check_use_freq_as_fsize},
			-anchor => 'w',
			-state => 'disabled',
	)->pack(-anchor => 'w');

	$self->{wc_smaller_nodes} = $lf2->Checkbutton(
			-text     => $self->gui_jchar('���٤ƤΥ����ɤ򾮤���αߤ�����','euc'),
			-variable => \$self->{check_smaller_nodes},
			-anchor   => 'w',
			-command  => sub{
				$self->{check_use_freq_as_size} = 0;
				$self->refresh(3);
			},
	)->pack(-anchor => 'w');

	# �ե���ȥ�����
	my $ff = $lf2->Frame()->pack(
		-fill => 'x',
		-padx => 2,
		-pady => 4,
	);

	$ff->Label(
		-text => $self->gui_jchar('�ե���ȥ�������'),
		-font => "TKFN",
	)->pack(-side => 'left');

	$self->{entry_font_size} = $ff->Entry(
		-font       => "TKFN",
		-width      => 3,
		-background => 'white',
	)->pack(-side => 'left', -padx => 2);
	$self->{entry_font_size}->insert(0,$::config_obj->r_default_font_size);
	$self->{entry_font_size}->bind("<Key-Return>",sub{$self->_calc;});
	$self->config_entry_focusin($self->{entry_font_size});

	$ff->Label(
		-text => $self->gui_jchar('%'),
		-font => "TKFN",
	)->pack(-side => 'left');

	$ff->Checkbutton(
			-text     => $self->gui_jchar('����','euc'),
			-variable => \$self->{check_bold_text},
			-anchor => 'w',
	)->pack(-anchor => 'w', -side => 'left');

	$ff->Label(
		-text => $self->gui_jchar(' �ץ��åȥ�������'),
		-font => "TKFN",
	)->pack(-side => 'left');

	$self->{entry_plot_size} = $ff->Entry(
		-font       => "TKFN",
		-width      => 4,
		-background => 'white',
	)->pack(-side => 'left', -padx => 2);
	$self->{entry_plot_size}->insert(0,'480');
	$self->{entry_plot_size}->bind("<Key-Return>",sub{$self->_calc;});
	$self->config_entry_focusin($self->{entry_plot_size});

	$win->Checkbutton(
			-text     => $self->gui_jchar('�¹Ի��ˤ��β��̤��Ĥ��ʤ�','euc'),
			-variable => \$self->{check_rm_open},
			#-anchor => 'nw',
	)->pack(-anchor => 'nw');

	# OK������󥻥�
	$win->Button(
		-text => $self->gui_jchar('����󥻥�'),
		-font => "TKFN",
		-width => 8,
		-command => sub{$self->close;}
	)->pack(-side => 'right',-padx => 2, -pady => 2, -anchor => 'se');

	$self->{ok_btn} = $win->Button(
		-text => 'OK',
		-width => 8,
		-font => "TKFN",
		-state => 'disable',
		-command => sub{$self->_calc;}
	)->pack(-side => 'right', -pady => 2, -anchor => 'se');

	$self->read_cfile;
	$self->refresh(3);

	return $self;
}

# �����ǥ��󥰥롼�롦�ե�������ɤ߹���
sub read_cfile{
	my $self = shift;
	
	$self->{hlist}->delete('all');
	
	unless (-e $self->cfile ){
		return 0;
	}
	
	my $cod_obj = kh_cod::func->read_file($self->cfile);
	
	unless (eval(@{$cod_obj->codes})){
		return 0;
	}

	my $left = $self->{hlist}->ItemStyle('window',-anchor => 'w');

	my $row = 0;
	foreach my $i (@{$cod_obj->codes}){
		
		$self->{checks}[$row]{check} = 1;
		$self->{checks}[$row]{name}  = $i->name;
		
		my $c = $self->{hlist}->Checkbutton(
			-text     => gui_window->gui_jchar($i->name,'euc'),
			-variable => \$self->{checks}[$row]{check},
			-command  => sub{ $self->check_selected_num;},
			-anchor => 'w',
		);
		
		$self->{checks}[$row]{widget} = $c;
		
		$self->{hlist}->add($row,-at => "$row");
		$self->{hlist}->itemCreate(
			$row,0,
			-itemtype  => 'window',
			-style     => $left,
			-widget    => $c,
		);
		++$row;
	}
	
	$self->check_selected_num;
	
	return $self;
}

# �����ɤ�3�İʾ����򤵤�Ƥ��뤫�����å�
sub check_selected_num{
	my $self = shift;
	
	my $selected_num = 0;
	foreach my $i (@{$self->{checks}}){
		++$selected_num if $i->{check};
	}
	
	if ($selected_num >= 3){
		$self->{ok_btn}->configure(-state => 'normal');
	} else {
		$self->{ok_btn}->configure(-state => 'disable');
	}
	return $self;
}

# ���٤�����
sub select_all{
	my $self = shift;
	foreach my $i (@{$self->{checks}}){
		$i->{widget}->select;
	}
	$self->check_selected_num;
	return $self;
}

# ���ꥢ
sub select_none{
	my $self = shift;
	foreach my $i (@{$self->{checks}}){
		$i->{widget}->deselect;
	}
	$self->check_selected_num;
	return $self;
}

# �����å��ܥå����������ư��
sub refresh{
	my $self = shift;

	my (@dis, @nor);
	if ($self->{radio} eq 'n'){
		push @nor, $self->{entry_edges_number};
		push @dis, $self->{entry_edges_jac};
	} else {
		push @nor, $self->{entry_edges_jac};
		push @dis, $self->{entry_edges_number};
	}

	if ($self->{check_use_freq_as_size}){
		push @nor, $self->{wc_use_freq_as_fsize};
		push @dis, $self->{wc_smaller_nodes};
	} else {
		push @dis, $self->{wc_use_freq_as_fsize};
		push @nor, $self->{wc_smaller_nodes};
	}

	if ($self->{check_smaller_nodes}){
		push @dis, $self->{wc_use_freq_as_size};
		push @dis, $self->{wc_use_freq_as_fsize};
	} else {
		push @nor, $self->{wc_use_freq_as_size};
	}

	if ( $self->{radio_type} eq 'words' ){
		push @dis, $self->{var_lab};
		$self->{var_obj}->disable;
	} else {
		push @nor, $self->{var_lab};
		$self->{var_obj}->enable;
	}


	foreach my $i (@nor){
		$i->configure(-state => 'normal');
	}

	foreach my $i (@dis){
		$i->configure(-state => 'disabled');
	}
	
	$nor[0]->focus unless $_[0] == 3;
}

# �ץ��åȺ�����ɽ��
sub _calc{
	my $self = shift;

	my @selected = ();
	foreach my $i (@{$self->{checks}}){
		push @selected, $i->{name} if $i->{check};
	}
	my $selected_num = @selected;
	if ($selected_num < 3){
		gui_errormsg->open(
			type   => 'msg',
			window  => \$self->win_obj,
			msg    => '�����ɤ�3�İʾ����򤷤Ƥ���������'
		);
		return 0;
	}

	my $wait_window = gui_wait->start;

	# �ǡ�������
	my $r_command;
	unless ( $r_command =  kh_cod::func->read_file($self->cfile)->out2r_selected($self->tani,\@selected) ){
		gui_errormsg->open(
			type   => 'msg',
			window  => \$self->win_obj,
			msg    => "�и�����0�Υ����ɤ����ѤǤ��ޤ���"
		);
		#$self->close();
		$wait_window->end(no_dialog => 1);
		return 0;
	}

	$r_command .= "\ncolnames(d) <- c(";
	foreach my $i (@{$self->{checks}}){
		my $name = $i->{name};
		substr($name, 0, 2) = ''
			if index($name,'��') == 0
		;
		$r_command .= '"'.$name.'",'
			if $i->{check}
		;
	}
	chop $r_command;
	$r_command .= ")\n";

	# ���Ф��μ��Ф�
	if (
		   $self->{radio_type} eq 'twomode'
		&& $self->{var_obj}->var_id =~ /h[1-5]/
	) {
		my $tani1 = $self->tani;
		my $tani2 = $self->{var_obj}->var_id;
		
		# ���Ф��ꥹ�Ⱥ���
		my $max = mysql_exec->select("SELECT max(id) FROM $tani2")
			->hundle->fetch->[0];
		my %heads = ();
		for (my $n = 1; $n <= $max; ++$n){
			$heads{$n} = Jcode->new(mysql_getheader->get($tani2, $n),'sjis')->euc;
		}

		my $sql = '';
		$sql .= "SELECT $tani2.id\n";
		$sql .= "FROM   $tani1, $tani2\n";
		$sql .= "WHERE \n";
		foreach my $i ("h1","h2","h3","h4","h5"){
			$sql .= " AND " unless $i eq "h1";
			$sql .= "$tani1.$i"."_id = $tani2.$i"."_id\n";
			if ($i eq $tani2){
				last;
			}
		}
		$sql .= "ORDER BY $tani1.id \n";
		
		my $h = mysql_exec->select($sql,1)->hundle;

		$r_command .= "\nv0 <- c(";
		while (my $i = $h->fetch){
			$r_command .= "\"$heads{$i->[0]}\",";
		}
		chop $r_command;
		$r_command .= ")\n";
		
	}

	# �����ѿ��μ��Ф�
	if (
		   $self->{radio_type} eq 'twomode'
		&& $self->{var_obj}->var_id =~ /^[0-9]+$/
	) {
		my $var_obj = mysql_outvar::a_var->new(undef,$self->{var_obj}->var_id);
		
		my $sql = '';
		if ($var_obj->{tani} eq $self->tani){
			$sql .= "SELECT $var_obj->{column} FROM $var_obj->{table} ";
			$sql .= "ORDER BY id";
		} else {
			my $tani1 = $self->tani;
			my $tani2 = $var_obj->{tani};
			$sql .= "SELECT $var_obj->{table}.$var_obj->{column}\n";
			$sql .= "FROM   $tani1, $tani2,$var_obj->{table}\n";
			$sql .= "WHERE \n";
			foreach my $i ("h1","h2","h3","h4","h5"){
				$sql .= " AND " unless $i eq "h1";
				$sql .= "$tani1.$i"."_id = $tani2.$i"."_id\n";
				if ($i eq $tani2){
					last;
				}
			}
			$sql .= " AND $tani2.id = $var_obj->{table}.id \n";
			$sql .= "ORDER BY $tani1.id \n";
		}
		
		$r_command .= "v0 <- c(";
		my $h = mysql_exec->select($sql,1)->hundle;
		my $n = 0;
		while (my $i = $h->fetch){
			if ( length( $var_obj->{labels}{$i->[0]} ) ){
				my $t = $var_obj->{labels}{$i->[0]};
				$t =~ s/"/ /g;
				$r_command .= "\"$t\",";
			} else {
				$r_command .= "\"$i->[0]\",";
			}
			++$n;
		}
		
		chop $r_command;
		$r_command .= ")\n";
	}

	# �����ѿ������Ф��ǡ���������
	if ($self->{radio_type} eq 'twomode'){
		$r_command .= &r_command_concat;
	}


	# �ǡ�������
	$r_command .= "\n";
	$r_command .= "d <- t(d)\n";
	$r_command .= "# END: DATA\n";

	my $fontsize = $self->gui_jg( $self->{entry_font_size}->get );
	$fontsize /= 100;

	use plotR::network;
	my $plotR = plotR::network->new(
		edge_type      => $self->gui_jg( $self->{radio_type} ),
		font_size      => $fontsize,
		plot_size      => $self->gui_jg( $self->{entry_plot_size}->get ),
		n_or_j         => $self->gui_jg( $self->{radio} ),
		edges_num      => $self->gui_jg( $self->{entry_edges_number}->get ),
		edges_jac      => $self->gui_jg( $self->{entry_edges_jac}->get ),
		use_freq_as_size => $self->gui_jg( $self->{check_use_freq_as_size} ),
		use_freq_as_fsize=> $self->gui_jg( $self->{check_use_freq_as_fsize} ),
		smaller_nodes    => $self->gui_jg( $self->{check_smaller_nodes} ),
		font_bold        => $self->gui_jg( $self->{check_bold_text} ),
		use_weight_as_width =>
			$self->gui_jg( $self->{check_use_weight_as_width} ),
		r_command      => $r_command,
		plotwin_name   => 'cod_netg',
	);

	# �ץ��å�Window�򳫤�
	$wait_window->end(no_dialog => 1);
	
	if ($::main_gui->if_opened('w_cod_netg_plot')){
		$::main_gui->get('w_cod_netg_plot')->close;
	}

	return 0 unless $plotR;

	gui_window::r_plot::cod_netg->open(
		plots       => $plotR->{result_plots},
		msg         => $plotR->{result_info},
		msg_long    => $plotR->{result_info_long},
		no_geometry => 1,
	);

	$plotR = undef;

	unless ( $self->{check_rm_open} ){
		$self->close;
		undef $self;
	}
	return 1;

}

#--------------#
#   ��������   #

sub cfile{
	my $self = shift;
	return $self->{codf_obj}->cfile;
}
sub tani{
	my $self = shift;
	return $self->{tani_obj}->tani;
}

sub win_name{
	return 'w_cod_netg';
}

sub r_command_concat{
	return '
# 1�Ĥγ����ѿ������ä��٥��ȥ��0-1�ޥȥꥯ�����Ѵ�
mk.dummy <- function(dat){
	dat  <- factor(dat)
	cols <- length(levels(dat))
	ret <- NULL
	for (i in 1:length( dat ) ){
		c <- numeric(cols)
		c[as.numeric(dat)[i]] <- 1
		ret <- rbind(ret, c)
	}
	colnames(ret) <- paste( "<>", levels(dat), sep="" )
	rownames(ret) <- NULL
	return(ret)
}
v1 <- mk.dummy(v0)

# ��и�ȳ����ѿ����ܹ�
n_words <- ncol(d)
d <- cbind(d, v1)

d <- subset(
	d,
	v0 != "��»��" & v0 != "." & v0 != "missing"
)
v0 <- NULL
v1 <- NULL

d <- t(d)
d <- subset(
	d,
	rownames(d) != "<>��»��" & rownames(d) != "<>." & rownames(d) != "<>missing"
)
d <- t(d)

';
}

1;