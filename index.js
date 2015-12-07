'use strict';
var React = require('react-native');
var {NativeMethodsMixin, Image, Text, ReactNativeViewAttributes, NativeModules, StyleSheet, View,requireNativeComponent, Dimensions} = React;
var window = Dimensions.get('window');
var CollectionView = React.createClass({
    mixins: [NativeMethodsMixin],

    propTypes: {
        frame: React.PropTypes.shape({
          x: React.PropTypes.number,
          y: React.PropTypes.number,
          width: React.PropTypes.number,
          height: React.PropTypes.number
        }),
        headerIdle: React.PropTypes.func,
        headerPulling: React.PropTypes.func,
        headerRefreshing: React.PropTypes.func,
        footerIdle: React.PropTypes.func,
        footerPulling: React.PropTypes.func,
        footerRefreshing: React.PropTypes.func,
        footerEndRefreshing: React.PropTypes.func,
        onRefresh: React.PropTypes.func,
        onInfinite: React.PropTypes.func,
        onPress: React.PropTypes.func
    },
    getDefaultProps: function(){
      return {
        frame: {x: 0, y: 0, width: window.width, height: window.height - 104},
        onRefresh: function(cb){
            cb && cb();
        },
        onInfinite: function(cb){
            cb && cb();
        },
        onPress: () => {},
        headerIdle: function(){
          return <Cell style={{width: window.width, height: 50, flex: 1, justifyContent: 'center'}}>
                    <Text style={{color: 'red', textAlign: 'center'}}>headerIdle</Text>
                </Cell>
        },
        headerPulling: function(){
          return <Cell style={{width: window.width, height: 50, flex: 1, justifyContent: 'center'}}>
                  <Text style={{color: 'red', textAlign: 'center'}}>headerPulling</Text>
                </Cell>
        },
        headerRefreshing: function(){
          return <Cell style={{width: window.width, height: 50, flex: 1, justifyContent: 'center'}}>
                  <Text style={{color: 'red', textAlign: 'center'}}>headerRefreshing...</Text>
                </Cell>
        },
        footerIdle: function(){
          return <Cell style={{width: window.width, height: 50, flex: 1, justifyContent: 'center'}}>
                    <Text style={{color: 'red', textAlign: 'center'}}>footerIdle</Text>
                </Cell>
        },
        footerPulling: function(){
          return <Cell style={{width: window.width, height: 50, flex: 1, justifyContent: 'center'}}>
                  <Text style={{color: 'red', textAlign: 'center'}}>footerPulling</Text>
                </Cell>
        },
        footerRefreshing: function(){
          return <Cell style={{width: window.width, height: 50, flex: 1, justifyContent: 'center'}}>
                  <Text style={{color: 'red', textAlign: 'center'}}>footerRefreshing...</Text>
                </Cell>
        },
        footerNoMoreData: function(){
          return <Cell style={{width: window.width, height: 50, flex: 1, justifyContent: 'center'}}>
                  <Text style={{color: '#9d9d9d', fontSize:14, textAlign: 'center'}}>没有更多数据了...</Text>
                </Cell>  
        }
      }
    },
    getInitialState: function() {
        return this._stateFromProps(this.props);
    },
    componentWillReceiveProps: function(nextProps) {
        var state = this._stateFromProps(nextProps);
        this.setState(state);
    },
    _stateFromProps: function(props) {
        var sections = [];
        var additionalItems = [];
        var children = [];
        var count = 0;
        var headerIdle = this.props.headerIdle();
    
        children.push(React.cloneElement(this.props.headerIdle(), {cellType: 'headerIdle', }));
        children.push(React.cloneElement(this.props.headerPulling(), {cellType: 'headerPulling'}));
        children.push(React.cloneElement(this.props.headerRefreshing(), {cellType: 'headerRefreshing'}));
        children.push(React.cloneElement(this.props.footerIdle(), {cellType: 'footerIdle', }));
        children.push(React.cloneElement(this.props.footerPulling(), {cellType: 'footerPulling'}));
        children.push(React.cloneElement(this.props.footerRefreshing(), {cellType: 'footerRefreshing'}));
        children.push(React.cloneElement(this.props.footerNoMoreData(), {cellType: 'footerNoMoreData'}));
        // iterate over children
        React.Children.forEach(props.children, function (child, itemIndex) {
            var items=[];
            if(child.type && child.type == CollectionView.Cell){
              var element = React.cloneElement(child, {key: itemIndex, cellType: 'cell', itemData:child.props.itemData});
              children.push(element);
              count++;
            }
        });
        return { children, count};
    },
    render: function() {
        return (
            <AKRNWaterfall
                {...this.props}
                ref={"CollectionView"}
                style={this.props.style}
                box={this.props.frame}
                cellCount={this.state.count}
                onRefresh={this._onRefresh}
                onInfinite={this._onInfinite}
                onClick={this._onPress}
                >
                {this.state.children}
            </AKRNWaterfall>
        );
    },
    _onRefresh: function(event){
        var reactTag = event.nativeEvent.reactTag || React.findNodeHandle(this);
        this.props.onRefresh(function(code){
            NativeModules.AKRNWaterfallManager.headerEndRefreshing(reactTag);
        });
    },
    _onInfinite: function(event){
        var reactTag = event.nativeEvent.reactTag || React.findNodeHandle(this);
        this.props.onInfinite(function(code){
            if(code == 'no-more-data'){
                NativeModules.AKRNWaterfallManager.footerEndRefreshingNoMoreData(reactTag, 60);
            }else{
                NativeModules.AKRNWaterfallManager.footerEndRefreshing(reactTag);
            }
        });
    },
    _onPress: function(event) {
       this.props.onPress(event.nativeEvent.itemData);
    },
});

CollectionView.Cell = React.createClass({
    getDefaultProps(){
        return {width:0, height:0}
    },
    render: function() {
        var styles = this.props.style || {};
        return <AKRNWaterfallCell {...this.props} componentWidth={styles.width} componentHeight={0}/>
    },
});
var Cell = CollectionView.Cell;
var AKRNWaterfallCell = requireNativeComponent('AKRNWaterfallCell', null);

var AKRNWaterfall = requireNativeComponent('AKRNWaterfall', null);
module.exports = CollectionView;