package at.dotpoint.processor;

import at.dotpoint.exception.NullArgumentException;
import at.dotpoint.dispatcher.event.generic.ProgressEvent;
import at.dotpoint.dispatcher.event.generic.ErrorEvent;
import at.dotpoint.dispatcher.event.generic.StatusEvent;
import at.dotpoint.dispatcher.event.IEventDispatcher;

//
class DataRequest<TInput,TData,TResult> extends ADataProcess<TInput,TResult>
{
    //
	public var loader:IDataProcess<TInput,TData>;
    public var parser:IDataProcess<TData,TResult>;

	//
	public var ratio:Float;

    //
    public function new( ?input:TInput, ?proxy:IEventDispatcher, ratio:Float = 0.5, weight:Float = 1 )
    {
        super( proxy, weight );

	    //
	    this.input = input;
		this.ratio = ratio;
    }

	// ************************************************************************ //
	// Methods
	// ************************************************************************ //

	//
	override public function start( ):Void
	{
		super.start();

		//
		this.setStatus( StatusEvent.STARTED, true );
		this.onProgress( null );

		//
		this.loader = this.getLoader();
		this.loader.input = this.input;
		this.loader.addListener( ProgressEvent.PROGRESS, this.onProgress );
		this.loader.addListener( StatusEvent.STOPPED,    this.onLoaderEvent );
		this.loader.addListener( StatusEvent.COMPLETE,   this.onLoaderEvent );
		this.loader.addListener( ErrorEvent.ERROR,       this.onError );
		this.loader.start();
	}

	//
	override public function stop( ):Void
	{
		super.stop();
		this.clear();

		this.setStatus( StatusEvent.STOPPED, true );
	}

	//
	override public function clear( ):Void
	{
		if( this.loader != null && this.loader.isProcessing )
		{
			this.loader.removeListener( ProgressEvent.PROGRESS, this.onProgress );
			this.loader.removeListener( StatusEvent.STOPPED,    this.onLoaderEvent );
			this.loader.removeListener( StatusEvent.COMPLETE,   this.onLoaderEvent );
			this.loader.removeListener( ErrorEvent.ERROR,       this.onError );
		}

		if( this.parser != null && this.parser.isProcessing )
		{
			this.parser.removeListener( ProgressEvent.PROGRESS, this.onProgress );
			this.parser.removeListener( StatusEvent.STOPPED,    this.onLoaderEvent );
			this.parser.removeListener( StatusEvent.COMPLETE,   this.onLoaderEvent );
			this.parser.removeListener( ErrorEvent.ERROR,       this.onError );
		}
	}

	// ------------------------------------------------------------------------ //
	// ------------------------------------------------------------------------ //

	/**
	 *
	 * @param	event
	 */
	private function onLoaderEvent( event:StatusEvent ):Void
	{
		this.loader.removeListener( ProgressEvent.PROGRESS, this.onProgress );
		this.loader.removeListener( StatusEvent.STOPPED,    this.onLoaderEvent );
		this.loader.removeListener( StatusEvent.COMPLETE,   this.onLoaderEvent );
		this.loader.removeListener( ErrorEvent.ERROR,       this.onError );

		// ------------- //

		switch( event.type )
		{
			case StatusEvent.COMPLETE:
			{
				//
				this.onProgress( null );

				//
				this.parser = this.getParser();
				this.parser.input = this.loader.result;
				this.parser.addListener( ProgressEvent.PROGRESS, this.onProgress );
				this.parser.addListener( StatusEvent.STOPPED,    this.onParserEvent );
				this.parser.addListener( StatusEvent.COMPLETE,   this.onParserEvent );
				this.parser.addListener( ErrorEvent.ERROR,       this.onError );
				this.parser.start();
			}

			//
			case StatusEvent.STOPPED:
			{
				if( this.isProcessing )
					this.stop();
			}

			//
			default:
				throw "unexpected task event: " + event.type;
		}
	}

	/**
	 *
	 * @param	event
	 */
	private function onParserEvent( event:StatusEvent ):Void
	{
		this.parser.removeListener( ProgressEvent.PROGRESS, this.onProgress );
		this.parser.removeListener( StatusEvent.STOPPED,    this.onLoaderEvent );
		this.parser.removeListener( StatusEvent.COMPLETE,   this.onLoaderEvent );
		this.parser.removeListener( ErrorEvent.ERROR,       this.onError );

		// ------------- //

		switch( event.type )
		{
			case StatusEvent.COMPLETE:
			{
				//
				this.onProgress( null );

				//
				this.result = this.parser.result;
				this.setStatus( StatusEvent.COMPLETE, true );
			}

			//
			case StatusEvent.STOPPED:
			{
				if( this.isProcessing )
					this.stop();
			}

			//
			default:
				throw "unexpected task event: " + event.type;
		}
	}

	// ------------------------------------------------------------------------ //
	// ------------------------------------------------------------------------ //

	//
	private function onError( event:ErrorEvent ):Void
	{
		if( this.hasListener( event.type ) )
			this.dispatch( event.type, event );

		this.clear();
	}

	//
	private function onProgress( parent:ProgressEvent ):Void
	{
		var current:Float = 0;

		if( this.isLoadingComplete() || this.isParsing() )
			current = this.ratio;

		if( parent != null )
		{
			if( this.isLoading() )
				current += parent.getRatio( ) * this.ratio;

			if( this.isParsing() )
				current += parent.getRatio( ) * (1 - this.ratio);
		}

		if( this.isParsingComplete() )
			current = 1.0;

		//
		var event:ProgressEvent = new ProgressEvent();
			event.current = current;
			event.total = 1;

		this.dispatch( ProgressEvent.PROGRESS, event );
	}

	// ------------------------------------------------------------------------ //
	// ------------------------------------------------------------------------ //

	//
	public function isLoading():Bool
	{
		if( this.loader != null && this.loader.isProcessing )
			return true;

		return false;
	}

	//
	public function isLoadingComplete():Bool
	{
		if( this.loader != null && this.loader.isComplete )
			return true;

		return false;
	}

	//
	public function isParsing():Bool
	{
		if( this.parser != null && this.parser.isProcessing )
			return true;

		return false;
	}

	//
	public function isParsingComplete():Bool
	{
		if( this.parser != null && this.parser.isComplete )
			return true;

		return false;
	}

	// ------------------------------------------------------------------------ //
	// ------------------------------------------------------------------------ //

	//
	private function getLoader():IDataProcess<TInput,TData>
	{
		if( this.loader == null )
			throw new NullArgumentException("loader");

		return this.loader;
	}

	//
	private function getParser():IDataProcess<TData,TResult>
	{
		if( this.parser == null )
			throw new NullArgumentException("parser");

		return this.parser;
	}
}
