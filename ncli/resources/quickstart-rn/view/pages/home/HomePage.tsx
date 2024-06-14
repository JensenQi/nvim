import * as React from 'react';
import { NavigationProp, ParamListBase, useNavigation } from '@react-navigation/native';
import { Image, View } from 'react-native';

import Cell from '../../components/Cell.tsx';

export default () => {
    const navigation: NavigationProp<ParamListBase> = useNavigation();
    return (
        <>
            <Image
                style={{ width: '100%', height: '20%', marginBottom: 10 }}
                source={{
                    uri: 'https://n.sinaimg.cn/translate/37/w1087h550/20180707/Fn9_-fzrwiaz8393458.png',
                }}
            />

            <View style={{ flexDirection: 'column', rowGap: 10 }}>
                <View style={{ flexDirection: 'row', columnGap: 10 }}>
                    <View style={{ flex: 1 }}>
                        <Cell
                            title={'SomePage1'}
                            icon={'timer-outline'}
                            onPress={() => navigation.navigate('PostDetail', { postId: 1 })}
                        />
                    </View>
                    <View style={{ flex: 1 }}>
                        <Cell
                            title={'SomePage2'}
                            icon={'weather-night-partly-cloudy'}
                            onPress={() => navigation.navigate('PostDetail', { postId: 2 })}
                        />
                    </View>
                </View>

                <View style={{ flexDirection: 'row', columnGap: 10 }}>
                    <View style={{ flex: 1 }}>
                        <Cell
                            title={'SomePage3'}
                            icon={'map'}
                            onPress={() => navigation.navigate('PostDetail', { postId: 3 })}
                        />
                    </View>
                    <View style={{ flex: 1 }}>
                        <Cell
                            title={'SomePage4'}
                            icon={'baseball'}
                            onPress={() => navigation.navigate('PostDetail', { postId: 4 })}
                        />
                    </View>
                </View>
            </View>
        </>
    );
};
