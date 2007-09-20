use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'         => 'Context::Handle',
    'VERSION_FROM' => 'lib/Context/Handle.pm',
    'PREREQ_PM'    => {
        'Want' => '0.10',
        'ok'   => '0'
    },
    'INSTALLDIRS' => 'site',
    'PL_FILES'    => {}
);
