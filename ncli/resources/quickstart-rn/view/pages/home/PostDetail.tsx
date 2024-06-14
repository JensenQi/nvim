import * as React from 'react';
import { Text } from 'react-native-paper';
import { RouteProp, useRoute } from '@react-navigation/native';

export default () => {
    const route = useRoute<RouteProp<{ params: { postId: number } }, 'params'>>();
    let { postId } = route.params;
    return <Text>Post detail of post id {postId}</Text>;
};
