const DRONE_TAKEOFF = 1;
const DRONE_LAND = 2;
const DRONE_FLY = 3;
const DRONE_ROTATE = 4;
const DRONE_STOP = 5;
var commands = [ 
    DRONE_TAKEOFF, 
    DRONE_FLY, DRONE_STOP, DRONE_ROTATE, DRONE_STOP, 
    DRONE_FLY, DRONE_STOP, DRONE_ROTATE, DRONE_STOP,
    DRONE_FLY, DRONE_STOP, DRONE_ROTATE, DRONE_STOP,
    DRONE_FLY, DRONE_STOP,
    DRONE_LAND
];
var arDrone = require( 'ar-drone' );
var client = arDrone.createClient();

function controlDrone( client, id ) {
    var tmp = '[cmd]: ';
    switch ( id ) {
        case 1:
            tmp += 'takeoff';
            client.takeoff();
            break;
        case 2:
            tmp += 'land';
            client.land();
            break;
        case 3:
            tmp += 'fly';
            client.after( 2000, function() {
                this.front( 0.3 );
            });
            break;
        case 4:
            tmp += 'rotate';
            client.after( 2500, function() {
                this.clockwise( 0.5 );
            });
            break;
        case 5:
            tmp += 'stop';
            client.after( 1000, function() {
                this.stop();
            });
            break;
        default:
            tmp += 'unknown command';
            break;
    }
    console.log( tmp );
}

commands.forEach( function( cmd ) {
    controlDrone( client, cmd );
});