$DBversion = 'XXX'; # will be replaced by the RM
if( CheckVersion( $DBversion ) ) {

    unless( foreign_key_exists( 'linktracker', 'linktracker_biblio_ibfk' ) ) {
        $dbh->do(q{ UPDATE linktracker SET biblionumber = NULL WHERE biblionumber NOT IN (SELECT biblionumber FROM biblio) });
        $dbh->do(q{ ALTER TABLE linktracker ADD CONSTRAINT `linktracker_biblio_ibfk` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE SET NULL ON UPDATE SET NULL });
    }

    unless( foreign_key_exists( 'linktracker', 'linktracker_item_ibfk' ) ) {
        $dbh->do(q{ UPDATE linktracker SET itemnumber = NULL WHERE itemnumber NOT IN (SELECT itemnumber FROM items) });
        $dbh->do(q{ ALTER TABLE linktracker ADD CONSTRAINT `linktracker_item_ibfk` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON DELETE SET NULL ON UPDATE SET NULL });
    }

    unless( foreign_key_exists( 'linktracker', 'linktracker_borrower_ibfk' ) ) {
        $dbh->do(q{ UPDATE linktracker SET borrowernumber = NULL WHERE borrowernumber NOT IN (SELECT borrowernumber FROM borrowers) });
        $dbh->do(q{ ALTER TABLE linktracker ADD CONSTRAINT `linktracker_borrower_ibfk` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE SET NULL ON UPDATE SET NULL });
    }

    # Always end with this (adjust the bug info)
    NewVersion( $DBversion, 22690, "Add constraints to linktracker table");
}