#!/usr/bin/env perl
# this script export csv data to google spreadsheet

use strict;
use warnings;
use utf8;
use open IO => ':encoding(UTF-8)';
binmode STDOUT, ":encoding(UTF-8)";

use Data::Dumper;
use Getopt::Long;
use Net::Google::Spreadsheets::V4;
use NKF;

use constant USAGE => <<MSG;
	usage : scriptname [-st] [-c]
	options :
	 -st OR --sheettitle	201805
     -c  OR --csv           csvfilename.csv
	 -h  OR --help	show this help

MSG

my $help = 0;
my $sheet_title;
my $csvfile;

GetOptions (
	"help|?"	=> \$help,
	"st:s{,}"	=> \$sheet_title,
	"c:s{,}"	=> \$csvfile,
);

die USAGE if $help;

$sheet_title ||= `(date +%Y%m)`;
chomp $sheet_title;

$csvfile ||= '/Users/iwahase_ryo/localdev/iwahase-um/data/26pjp_growth_hack.pl.csv';

## refresh tokenの取得方法は備忘録を参照すること
my $gs = Net::Google::Spreadsheets::V4->new(
    client_id =>
        '305031561642-c2k7gfj9ook9qqkapno3me0sa4f916kc.apps.googleusercontent.com',
    client_secret  => '8gLp-mPeEwc1hLZWKgwHEStc',
    #access_token => 'ya29.GlvYBcN66U_c_rXmG_0XeR2_gq1hYqgWro8I_wc22HzdzGmyXZ--mlasOEf24rz58WA7PsGHAVmIUapTiV7clLr0tGs0O-z4AbdpshudfCuSKNT5GtqZmJTVMvuB',
    refresh_token  => '1/CNHA4EAkNYQPnN00aHYfsa9G44hAXGBFatLZmm9OJ_g',
    spreadsheet_id => '1VhtPQfUXoPvMc2NWsxNAgDi7p7vlpTcevNvW_VOsKLs',
);

my ($content, $res);
my $sheet = $gs->get_sheet(title => $sheet_title);

## create sheet if sheet does not exist
unless ($sheet) {
    ($content, $res) = $gs->request(
        POST    => ':batchUpdate',
        {
            requests => [
                {
                    addSheet => {
                        properties => {
                            title => $sheet_title,
                            inddx => 0,
                        },
                    },
                },
            ],
        },
    );
    $sheet = $content->{replies}[0]{addSheet};
}
my $sheet_prop = $sheet->{properties};
# sheet_propのキー名はgsのキー名

# clear all cells
$gs->clear_sheet(sheet_id => $sheet_prop->{sheetId});

my @requests;
my $idx  = 0;
my @file = openFileIntoScalarArray( $csvfile, 1 );

for my $line (@file) {
    # print $line;
    push @requests, {
        pasteData => {
            coordinate => {
                sheetId     => $sheet_prop->{sheetId},
                rowIndex    => $idx++,
                columnIndex => 0,
            },
            data => $gs->to_csv(split(/\t/, $line)),
            type => 'PASTE_NORMAL',
            delimiter => ',',
        },
    };
}

# format a header row
push @requests,
    {
        repeatCell => {
            range => {
                sheetId       => $sheet_prop->{sheetId},
                startRowIndex => 0,
                endRowIndex   => 1,
            },
            cell => {
                userEnteredFormat => {
                    backgroundColor => {
                        red   => 0.0,
                        green => 1.0,
                        blue  => 1.0,
                    },
                    horizontalAlignment => 'CENTER',
                    textFormat          => {
                        foregroundColor => {
                            red   => 0.0,
                            green => 0.0,
                            blue  => 0.0
                        },
                        bold => \1,
                    },
                    borders => {
                        top => {
                            style => 'SOLID',
                            color => {
                                red   => 1.0,
                                green => 1.0,
                                blue  => 1.0
                            },
                            width => 100,
                        },
                        bottom => { style => 'SOLID', },
                        left   => { style => 'SOLID', },
                        right  => { style => 'SOLID', },
                    },
                },
            },
            fields =>
                'userEnteredFormat(borders, backgroundColor,textFormat,horizontalAlignment)',
        },
    };

# format rows
push @requests,
    {
        repeatCell => {
            range => {
                sheetId       => $sheet_prop->{sheetId},
                startRowIndex => 1,
                endRowIndex   => ($idx -1),
            },
            cell => {
                userEnteredFormat => {
                    # backgroundColor => {
                    #     red   => 1.0,
                    #     green => 1.0,
                    #     blue  => 0.0,
                    # },
                     horizontalAlignment => 'CENTER',
                    # textFormat          => {
                    #     foregroundColor => {
                    #         red   => 0.0,
                    #         green => 0.0,
                    #         blue  => 0.0
                    #     },
                    #     bold => \1,
                    # },
                    borders => {
                        top => {
                            style => 'SOLID',
                            color => {
                                red   => 0.0,
                                green => 0.0,
                                blue  => 0.0
                            },
                        },
                        bottom => { 
                             style => 'SOLID',
                             color => {
                                 red   => 0.0,
                                 green => 0.0,
                                 blue  => 0.0
                             },
                         },
                        left   => {
                            style => 'SOLID',
                            color => {
                                red   => 0.0,
                                green => 0.0,
                                blue  => 0.0
                            },
                        },
                        right  => { 
                            style => 'SOLID',
                            color => {
                                red   => 0.0,
                                green => 0.0,
                                blue  => 0.0
                            },
                        },
                    },
                },
            },
            fields =>
                'userEnteredFormat(borders)',
        },
    };

# last row
push @requests,
    {
        repeatCell => {
            range => {
                sheetId       => $sheet_prop->{sheetId},
                startColumnIndex => 3,
                startRowIndex => ($idx - 1),
                endRowIndex   => $idx,
            },
            cell => {
                userEnteredFormat => {
                    # backgroundColor => {
                    #     red   => 1.0,
                    #     green => 1.0,
                    #     blue  => 0.0,
                    # },
                    #horizontalAlignment => 'CENTER',
                    textFormat          => {
                    #     foregroundColor => {
                    #         red   => 0.0,
                    #         green => 0.0,
                    #         blue  => 0.0
                    #     },
                        fontSize => 11,
                         bold => \1,
                    },
                    borders => {
                        top => {
                            style => 'SOLID',
                            color => {
                                red   => 0.0,
                                green => 0.0,
                                blue  => 0.0
                            },
                        },
                        bottom => { 
                             style => 'SOLID',
                             color => {
                                 red   => 0.0,
                                 green => 0.0,
                                 blue  => 0.0
                             },
                         },
                        left   => {
                            style => 'SOLID',
                            color => {
                                red   => 0.0,
                                green => 0.0,
                                blue  => 0.0
                            },
                        },
                        right  => { 
                            style => 'SOLID',
                            color => {
                                red   => 0.0,
                                green => 0.0,
                                blue  => 0.0
                            },
                        },
                    },
                },
            },
            fields =>
                'userEnteredFormat(borders, textFormat)',
        },
    };

($content, $res) = $gs->request(
    POST => ':batchUpdate',
    {
        requests => \@requests,
    },
);

exit;

sub openFileIntoScalarArray {
    my ($file, $option) = @_;
    #my $file = shift;

    return "" if !defined $file;

    # optionがある場合は配列で返す
    if ($option) {
        open( FH, $file );
        my @retfile = <FH>;
        close(FH);
        return @retfile;
    }

    my $retfile;
    local $/;
    local *F;
    open( F, "< $file\0" ) || return;
    $retfile = <F>;
    close(F);

    return ($retfile);
}



__END__
Net::Google::Spreadsheets::V4のメソッドリスト
'Net::Google::Spreadsheets::V4::endpoint',
'Net::Google::Spreadsheets::V4::to_json',
'Net::Google::Spreadsheets::V4::debugf',
'Net::Google::Spreadsheets::V4::croakff',
'Net::Google::Spreadsheets::V4::encode_json',
'Net::Google::Spreadsheets::V4::new',
'Net::Google::Spreadsheets::V4::get_sheet',
'Net::Google::Spreadsheets::V4::clear_sheet',
'Net::Google::Spreadsheets::V4::csv',
'Net::Google::Spreadsheets::V4::croak',
'Net::Google::Spreadsheets::V4::croakf',
'Net::Google::Spreadsheets::V4::warnf',
'Net::Google::Spreadsheets::V4::critf',
'Net::Google::Spreadsheets::V4::request',
'Net::Google::Spreadsheets::V4::carp',
'Net::Google::Spreadsheets::V4::to_csv',
'Net::Google::Spreadsheets::V4::infoff',
'Net::Google::Spreadsheets::V4::decode_json',
'Net::Google::Spreadsheets::V4::ua',
'Net::Google::Spreadsheets::V4::ddf',
'Net::Google::Spreadsheets::V4::objToJson',
'Net::Google::Spreadsheets::V4::from_json',
'Net::Google::Spreadsheets::V4::column_notation',
'Net::Google::Spreadsheets::V4::_initialize',
'Net::Google::Spreadsheets::V4::jsonToObj',
'Net::Google::Spreadsheets::V4::debugff',
'Net::Google::Spreadsheets::V4::retry',
'Net::Google::Spreadsheets::V4::confess',
'Net::Google::Spreadsheets::V4::warnff',
'Net::Google::Spreadsheets::V4::infof',
'Net::Google::Spreadsheets::V4::a1_notaion',
'Net::Google::Spreadsheets::V4::spreadsheet_id',
'Net::Google::Spreadsheets::V4::critff'
